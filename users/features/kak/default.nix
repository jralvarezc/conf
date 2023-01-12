{ config, lib, pkgs, ... }:

{

  xdg.configFile."kak/kakrc".source = ./kakrc;
  xdg.configFile."kak/colors/dracula.kak".source = ./colors/dracula.kak;
  xdg.configFile."kak/colors/dracula-transparent.kak".source = ./colors/dracula-transparent.kak;

}
