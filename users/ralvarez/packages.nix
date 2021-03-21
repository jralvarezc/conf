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
    sd
    bat
    ripgrep
    exa
    pcre2
    pcre
    most
    fzf
    zoxide
    fasd
    tldr

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
    kakoune
    mdp

    # devel
    git
    hyperfine

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
    httpie

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

    # screen
    arandr
    autorandr
    xorg.xbacklight

    # image
    zathura
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
