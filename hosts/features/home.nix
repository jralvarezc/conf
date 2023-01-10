{ config, lib, pkgs, ... }:

{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  # needed for the buggy home-manager.impermanence
  home-manager.sharedModules = [];

}
