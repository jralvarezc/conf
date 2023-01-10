{ config, lib, pkgs, ... }:

{

  home.stateVersion = "18.09";

  imports = [
    ./features/git
  ];

}
