{ config, pkgs, ... }:

{

  services.xserver = {

    displayManager.defaultSession = "none+xmonad";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [ hp.dbus hp.monad-logger hp.xmonad-contrib ];
      config = ./config.hs;
    };

  };

}
