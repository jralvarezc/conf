{config, lib, pkgs, ... }:

let
  inherit (pkgs) callPackage;
  restic-b2 = pkgs.callPackage ./services/restic/restic-b2.nix {};
in
{

  home.packages = with pkgs; [
    restic-b2
    teams # chat
    wget git bc zip unzip unrar tree fzf # tools
    mkpasswd pwgen # crypto
    nox # nix
    neovim
    freemind vym xmind # mind mapping
    # for jekyll (TODO: move to dev-env)
    bundler zlib bundix
    opencv openssl xorg.libXmu stdenv.cc # timedoctor
    zathura feh maim xclip xorg.xev graphviz # viewers
    mplayer
    vorbis-tools ffmpeg # sound
    emacs-nox
    diction aspell aspellDicts.es aspellDicts.en
    arandr autorandr # monitor
    xorg.xbacklight
    keybase kbfs keybase-gui # sequoia # pgp
    _1password sops # password
    chromium brave firefox links lynx # browsers
    netcat-gnu nmap
    bat ripgrep eva exa
    pcre2 pcre most
  ];

}
