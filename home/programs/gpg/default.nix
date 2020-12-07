{config, lib, pkgs, ... }:

{

  programs.gpg.enable = true;
  home.file.".gnupg/gpg.conf".source = ./gpg.conf;

}
