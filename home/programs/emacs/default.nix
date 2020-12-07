{config, lib, pkgs, ... }:
{

  home.file.".emacs".source = ./emacs;
  home.sessionVariables.EDITOR = "emacs";

}
