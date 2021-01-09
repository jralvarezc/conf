{ config, pkgs, ... }:

{

  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # Enable touchpad

    # avoiding third passphrase asked
    displayManager.autoLogin.enable = true;
  };

  fonts = {
    fonts = [
      pkgs.google-fonts
    ];
    fontconfig.dpi = 135; # 135?
  };

  environment.systemPackages = with pkgs; [
    kitty
    libnotify
    font-manager
    powerline-fonts
  ];

}
