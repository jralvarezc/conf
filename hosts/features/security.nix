{ config, lib, pkgs, ... }:

{

  security = {
    auditd.enable = true;
  };

  # Enable doas instead of sudo
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      groups = [ "wheel" ];
      noPass = true;
	    keepEnv = true;
    }];
  };

}
