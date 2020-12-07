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

  };

  fonts = {
    fonts = [ pkgs.google-fonts ];
    fontconfig.dpi = 135; # 135?
  };

  environment.systemPackages = with pkgs; [
    kitty
    libnotify
    font-manager
    powerline-fonts
  ];

}
