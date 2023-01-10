{ config, pkgs, inputs, ... }:

{

  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];  

  environment.persistence."/persistent" = {
    directories = [ 
      #"/var/lib/systemd" 
      #"/var/log" 
    ];
    files = [
      #"/etc/machine-id"
    ];
  };

}
