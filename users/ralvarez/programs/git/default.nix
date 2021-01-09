{ config, lib, pkgs, ... }:

{

  home.file.".gitconfig".source = ./gitconfig;

}
