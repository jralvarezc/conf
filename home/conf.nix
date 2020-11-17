{config, lib, pkgs, ... }:

let
  inherit (pkgs) callPackage;
  pgp-fp = "CED96DF463D7B86A1C4B1322BE6C92145BFF4A34";
in
{

  imports = [
    ./services/backup.nix
  ];

  systemd.user.startServices = true;

  home.packages = with pkgs; [
    (import ./wrappers/restic-b2.nix)
    teams # chat
    wget git bc zip unzip tree fzf # tools
    mkpasswd pwgen # crypto
    nox # nix
    freemind vym xmind # mind mapping
    # for jekyll (TODO: move to dev-env)
    bundler zlib bundix
    opencv openssl xorg.libXmu stdenv.cc # timedoctor
    zathura feh maim xclip xorg.xev graphviz # viewers
    mplayer
    vorbis-tools ffmpeg # sound
    emacs25-nox
    diction aspell aspellDicts.es aspellDicts.en
    #libreoffice-still # editors
    gitlab-runner # ci
    arandr autorandr # monitor
    termite tmux # terminal
    xorg.xbacklight
    keybase kbfs keybase-gui # sequoia # pgp
    _1password sops # password
    chromium brave firefox links lynx # browsers
    netcat-gnu nmap
    bat ripgrep eva exa broot
    pcre2 pcre most
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
    PAGER = "less -R";
    SOPS_PGP_FP = pgp-fp;
  };

  services.screen-locker = {
    enable = true;
    inactiveInterval = 1;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -f -c 000000";
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        stack_duplicates = false;
        geometry = "365x15-21+21";
        show_age_threshold = 1;
        history_length = 20;
        horizontal_padding = 16;
        indicate_hidden = true;
        padding = 12;
        startup_notification = [ "true" ];
        word_wrap = true;
      };

      shortcuts = {
        close_all = "mod4+shift+a";
        history = "mod4+shift+h";
      };

      urgency_low = {
        background = "#00ff00"; # green
        timeout = 30;
      };

      urgency_normal = {
        background = "#ffff00"; # yellow
        foreground = "#000000"; # black
        timeout = 60;
      };

      urgency_critical = {
        background = "#ff0000"; # red
        timeout = 0;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      path = ".config/zsh/.zsh_history";
      ignoreDups = true;
      share = true;
      size = 1000000;
    };
    initExtra = ''
	    sops -d conf/secrets.yml > /dev/null 2>&1
      bindkey '^R' history-incremental-search-backward
    '';
    shellAliases = {
      mv = "mv -i";
      cp = "cp -i";
      rm = "rm -i";
      ls = "ls --color=always";
      rg = "rg --color=always";
      jq = "jq -C";
      prune = ''restic-b2 forget --prune --keep-last 1 --keep-within 24h\
                  --keep-daily 7 --keep-weekly 12 --keep-monthly 36\
                  --keep-yearly 15'';
      backup = ''restic-b2 backup --exclude=/home/ralvarez/.cache\
                   --one-file-system --verbose /home/ralvarez'';
      shutdown = "echo Use: systemctl poweroff";
      reboot = "echo Use: systemctl reboot";
      nano = "echo Use: emacs";
      vi = "echo Use: emacs";
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "pip" "sudo" "command-not-found"];
      theme = "agnoster";
    };
  };

  programs.broot.enable = true;

  programs.fzf.enableZshIntegration = true;

  programs.chromium.extensions = [
    "fdjamakpfbbddfjaooikfcpapjohcfmg" # dashlane
    "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # offlinedocs
    "ioalpmibngobedobkmbhgmadaphocjdn" # onelogin
    "niloccemoadcdkdjlinkgdfekeahmflj" # pocket
    "niepjjjfafhadmfdminbckmciijcaagc" # trimless
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".emacs".source = ./sources/emacs;
  home.file.".gitconfig".source = ./sources/gitconfig;

  programs.gpg.enable = true;
  home.file.".gnupg/gpg.conf".source = ./sources/gpg.conf;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 86400; # 24 hours
    maxCacheTtl = 604800; # 1 week
    extraConfig = "pinentry-program ${pkgs.pinentry}/bin/pinentry";
    # echo RELOADAGENT | gpg-connect-agent
  };

  xdg.configFile."i3/config".source = ./sources/i3.conf;
  xdg.configFile."i3status/config".source = ./sources/i3status.conf;

  xdg.configFile."kitty/kitty.conf".source = ./sources/kitty/kitty.conf;
  xdg.configFile."kitty/theme.conf".source = ./sources/kitty/themes/tango-dark.conf;

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

  programs.home-manager = {
    enable = true;
    path = "...";
  };

}
