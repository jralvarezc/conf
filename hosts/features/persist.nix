{ config, pkgs, inputs, ... }:

{

  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];  

  # /nix/backup will be backed up, /nix/persist no (just reboots)
  environment.persistence."/nix/persist" = {
    hideMounts = false;
    directories = [ 
      "/var/lib/iwd"
      "/var/lib/bluetooth"
    ];
    files = [
    ];
  };

}
