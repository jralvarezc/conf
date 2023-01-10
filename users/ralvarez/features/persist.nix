{ config, pkgs, ... }:

{

  fileSystems."/home/ralvarez" = { 
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "defaults" "size=4G" "mode=755" ];
    neededForBoot = true;
  };

  # using nixos module, home-manager seems with race conditions.
  # /nix/backup will be backed up, /nix/persist no (just reboots)
  environment.persistence."/nix/backup".users.ralvarez = {
    directories = [
      "conf"
      "data"
      "git"
      ".ssh"
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
