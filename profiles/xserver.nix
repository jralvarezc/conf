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

  environment.systemPackages = with pkgs; [
    kitty
    libnotify
  ];

}
