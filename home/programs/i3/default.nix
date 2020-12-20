{config, lib, pkgs, ... }:

{

  xdg.configFile."i3/config".source = ./i3.conf;
  xdg.configFile."i3status/config".source = ./i3status.conf;

  services.screen-locker = {
    enable = true;
    inactiveInterval = 5;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -f -c 000000";
  };

  home.packages = with pkgs; [
    i3status
    dmenu
  ];

}
