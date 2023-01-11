{ config, pkgs, ... }:

{

  fileSystems."/home/ralvarez" = { 
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" "mode=700" ];
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
      ".config/op"
      ".config/fontconfig"
      ".config/xrandr"
      ".config/chromium/Default"
      ".config/zsh"
      ".config/i3"
      ".config/kitty"
      ".config/dunst"
    ];
    files = [
    ];
  };

}
