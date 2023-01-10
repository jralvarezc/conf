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

    ## TODO: refactor
    ../features/gpg
    ../features/gpg.nix

    # custom features
    ./features/restic
    ./features/zsh.nix
    ./features/git

  ];

  home.sessionVariables = {
    PAGER = "less -R";
  };

  xdg.configFile."user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/.xdg/desktop"
    XDG_DOWNLOAD_DIR="$HOME/.xdg/downloads"
    XDG_DOCUMENTS_DIR="$HOME/.xdg/documents"
    XDG_MUSIC_DIR="$HOME/.xdg/music"
    XDG_PICTURES_DIR="$HOME/.xdg/pictures"
    XDG_VIDEOS_DIR="$HOME/.xdg/videos"
    XDG_TEMPLATES_DIR="$HOME/.xdg/templates"
    XDG_PUBLICSHARE_DIR="$HOME/.xdg/share"
  '';

  systemd.user.startServices = true;

}
