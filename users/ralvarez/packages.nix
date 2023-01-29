{ config, lib, pkgs, ... }:
{

  home.packages = with pkgs; [

    # transfer
    wget

    # debug
    gdb

    # packages
    dpkg
    manix

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
    mprocs

    # mail
    mailspring
    evolution
    thunderbird
    kmail
    gnome.geary
    sylpheed

    # compress
    zip
    unzip
    unrar

    # edit
    pandoc
    diction
    aspell
    aspellDicts.es
    aspellDicts.en
    kakoune
    mdp
    abiword

    # devel
    git
    hyperfine

    # crypto
    mkpasswd
    pwgen
    age
    keybase
    kbfs
    keybase-gui

    # network
    netcat-gnu
    nmap

    # browser
    chromium
    brave
    firefox
    links2
    lynx
    elinks

    # mail
    mutt
    hydroxide

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
    maim
    xclip
    xorg.xev
    graphviz

    # media
    vorbis-tools
    ffmpeg

    # conference
    teams

    # mind mapping
    freemind
    vym
    xmind
  ];

}
