{ config, lib, pkgs, ... }:
{

  home.stateVersion = "18.09";

  imports = [
    ./packages.nix

    # generic features
    ../features/direnv.nix
    ../features/dunst.nix
    ../features/kitty
    ../features/chromium.nix
    ../features/i3
    ../features/xdg.nix
    ../features/kak

    ## TODO: refactor
    ../features/gpg
    ../features/gpg.nix

    # custom features
    ./features/restic.nix
    ./features/rclone.nix
    ./features/zsh.nix
    ./features/xrandr.nix
    ./features/git

  ];

  home.sessionVariables = {
    PAGER = "less -R";
  };

  programs.command-not-found.enable = false;
  programs.fzf.enableZshIntegration = true;
  systemd.user.startServices = true;

}
