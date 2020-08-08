{ config, pkgs, ... }:

{
  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # Enable touchpad

    displayManager.autoLogin = {
      enable = true; # avoiding third passphrase asked
      user = "ralvarez";
    };

    displayManager.defaultSession = "none+i3";

    windowManager = {
      i3.enable = true;
    };

    xautolock = {
      enable = true;
      locker = "${pkgs.i3lock}/bin/i3lock -f -c 000000";
      time = 3;
    };
  };

  fonts = {
    fonts = [ pkgs.google-fonts ];
    fontconfig.dpi = 135; # 135?
  };

  environment.systemPackages = with pkgs; [
    termite
    xscreensaver i3status i3lock i3blocks dmenu # wm
    dunst libnotify
    font-manager powerline-fonts
  ];


}
