{ config, lib, pkgs, ... }:

{

  home.stateVersion = "18.09";

  imports = [
    ./packages.nix
    ./services/restic
    ./programs/i3
    ./programs/zsh.nix
    ./programs/git
    ./programs/gpg
    ./programs/kitty
    ./programs/chromium.nix
    ../profiles/direnv.nix
    ../profiles/dunst.nix
    ../profiles/gpg.nix
  ];

  home.sessionVariables = {
    PAGER = "less -R";
    SOPS_PGP_FP = "CED96DF463D7B86A1C4B1322BE6C92145BFF4A34";
  };

  xdg.configFile."user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/xdg/desktop"
    XDG_DOWNLOAD_DIR="$HOME/xdg/downloads"
    XDG_DOCUMENTS_DIR="$HOME/xdg/documents"
    XDG_MUSIC_DIR="$HOME/xdg/music"
    XDG_PICTURES_DIR="$HOME/xdg/pictures"
    XDG_VIDEOS_DIR="$HOME/xdg/videos"
    XDG_TEMPLATES_DIR="$HOME/xdg/templates"
    XDG_PUBLICSHARE_DIR="$HOME/xdg/share"
  '';

  systemd.user.startServices = true;

}
