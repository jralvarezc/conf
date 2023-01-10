{ config, pkgs, ... }:

{

  environment.persistence."/nix/backup".users.ralvarez = {
    directories = [
#      ".cache/nix"
      "conf"
      "data"
      "git"
      ".gnupg"
#      ".thunderbird"
      ".config/fontconfig"
      ".screenlayout"
      ".config/chromium/Default"
      ".config/zsh"
      ".config/i3"
      ".config/i3status" 
      ".config/kitty"
      ".config/dunst"
#      ".config/systemd"
    ];
    files = [
      ".config/rclone/rclone.conf"    
    ];
  };

}
