{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    _1password
    rclone
  ];

  home.file.".config/rclone/env".text = ''
    RCLONE_CONFIG_B2_TYPE = "b2"
    RCLONE_CONFIG_B2_ACCOUNT = "op://Personal/rclone/account"
    RCLONE_CONFIG_B2_KEY = "op://Personal/rclone/key"
  '';

  programs.zsh.shellAliases = {
    sync = ''
      op run --env-file="/home/ralvarez/.config/rclone/env" -- \
      rclone sync \
             -P \
             -l \
             /nix/backup/home/ralvarez/ \
             b2:jralvarezc/rclone
    '';
  };

}
