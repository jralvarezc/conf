{ config, lib, pkgs, ... }:
let
  inherit (pkgs) callPackage;
  restic-b2 = pkgs.callPackage ./services/restic/restic-b2.nix { };
in
{

  home.packages = with pkgs; [
    # transfer
    restic-b2
    wget
    magic-wormhole

    # files
    tree
    lf
    nnn
    fd
    bat
    ripgrep
    exa
    pcre2
    pcre
    most
    fzf

    # compress
    zip
    unzip
    unrar

    # edit
    pandoc
    emacs-nox
    diction
    aspell
    aspellDicts.es
    aspellDicts.en

    # devel
    git

    # crypto
    mkpasswd
    pwgen
    age
    sequoia
    keybase
    kbfs
    keybase-gui
    _1password
    sops

    # network
    netcat-gnu
    nmap

    # browser
    chromium
    brave
    firefox
    links
    lynx

    # calc
    eva

    # other
    xsv
    wtf
    neofetch

    # screen
    arandr
    autorandr
    xorg.xbacklight

    # image
    zathura
    feh
    maim
    xclip
    xorg.xev
    graphviz

    # media
    mplayer
    vorbis-tools
    ffmpeg

    # conference
    teams

    # mind mapping
    freemind
    vym
    xmind

    # for jekyll (TODO: move to dev-env)
    #bundler zlib bundix
    #opencv openssl xorg.libXmu stdenv.cc # timedoctor

  ];

}
