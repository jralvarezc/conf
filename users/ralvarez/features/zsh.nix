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
      export PATH=$PATH:~/.local/bin

      bindkey '^R' history-incremental-search-backward
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"
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
      nano = "kak";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "pip" "fasd" ];
    };

  };

}
