{ config, lib, pkgs, ... }:

{

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."direnv/lib/use_flake.sh" = {
    source = pkgs.writeText "flake-support" ''
      use_flake() {
        watch_file flake.nix
        watch_file flake.lock
        eval "$(nix print-dev-env)"
      }
    '';
  };

}
