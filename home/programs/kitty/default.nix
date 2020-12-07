{config, lib, pkgs, ... }:

{

  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
  xdg.configFile."kitty/theme.conf".source = ./themes/tango-dark.conf;

}
