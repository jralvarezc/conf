{ config, pkgs, ... }:

{

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-wlr
  ];

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
