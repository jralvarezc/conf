{ config, lib, pkgs, ... }:

{

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
            neofetch
            source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
          '';

    shellAliases = {
      mv = "mv -i";
      cp = "cp -i";
      rm = "rm -i";
      ls = "exa";
      cat = "bat";
      less = "bat";
      more = "bat";
      rg = "rg --color=always";
      jq = "jq -C";
      prune = ''
        restic-b2 forget --prune --keep-last 1 --keep-within 24h\
                          --keep-daily 7 --keep-weekly 12 --keep-monthly 36\
                          --keep-yearly 15'';
      backup = ''
        restic-b2 backup --exclude=/home/ralvarez/.cache\
                           --one-file-system --verbose /home/ralvarez'';
      shutdown = "echo Use: systemctl poweroff";
      reboot = "echo Use: systemctl reboot";
      nano = "echo Use: emacs";
      vi = "echo Use: emacs";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "pip" "sudo" ];
      theme = "agnoster";
    };
  };

  programs.command-not-found.enable = false;

  programs.fzf.enableZshIntegration = true;

}
