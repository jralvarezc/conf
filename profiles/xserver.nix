{ config, pkgs, ... }:

{

  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # Enable touchpad
    dpi = 135;

    # avoiding third passphrase asked
    displayManager.autoLogin.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
    libnotify
  ];

}
