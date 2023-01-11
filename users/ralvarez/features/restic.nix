{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    _1password
    restic
  ];

  home.file.".config/restic/env".text = ''
    B2_ACCOUNT_ID = "op://Personal/backblaze/account_id"
    B2_ACCOUNT_KEY = "op://Personal/backblaze/account_key"
    RESTIC_REPOSITORY = "op://Personal/restic/repository"
    RESTIC_PASSWORD = "op://Personal/restic/password"
  '';

  programs.zsh.shellAliases = {
    prune = ''
      op run --env-file="/home/ralvarez/.config/restic/env" -- \
      restic forget \
             --prune \
             --keep-last 1 \
             --keep-within 24h \
             --keep-daily 7 \
             --keep-weekly 12 \
             --keep-monthly 36 \
             --keep-yearly 15
    '';

    backup = ''
      op run --env-file="/home/ralvarez/.config/restic/env" -- \
      restic backup \
             /home/ralvarez \
             --exclude=.cache \
             --verbose
    '';
  };

}
