{ config, pkgs, ... }:
let
  login = "root";
in
{

  # home-manager configuration for user
  home-manager.users."${login}" = import ./home.nix;

}
