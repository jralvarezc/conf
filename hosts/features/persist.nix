{ config, pkgs, inputs, ... }:

{

  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];  

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
