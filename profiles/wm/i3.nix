{ config, pkgs, ... }:

{

  services.xserver = {

    displayManager.defaultSession = "none+i3";
    windowManager = { i3.enable = true; };

  };

}
