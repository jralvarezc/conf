{ config, lib, pkgs, ... }:

{
  services.tlp.enable = true;

  services.logind = {
    lidSwitch = "hibernate";
    lidSwitchExternalPower = "ignore";
  };

}
