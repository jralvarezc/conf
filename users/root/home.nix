{ config, lib, pkgs, ... }:

{

  home.stateVersion = "18.09";

  imports = [
    ./programs/git
  ];

}
