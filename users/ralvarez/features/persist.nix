{ config, pkgs, ... }:

{

  fileSystems."/home/ralvarez" = { 
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "defaults" "size=4G" "mode=755" ];
    neededForBoot = true;
  };

  # using nixos module, home-manager seems with race conditions.
  environment.persistence."/nix/backup".users.ralvarez = {
    directories = [
      "conf"
      "data"
      "git"
      ".gnupg"
#      ".thunderbird"
      ".config/fontconfig"
      ".config/xrandr"
      ".config/chromium/Default"
      ".config/zsh"
      ".config/i3"
      ".config/kitty"
      ".config/dunst"
    ];
    files = [
      ".config/rclone/rclone.conf"    
    ];
  };

}
