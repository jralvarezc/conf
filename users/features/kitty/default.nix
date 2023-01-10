{ config, lib, pkgs, ... }:

{

  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
  xdg.configFile."kitty/theme.conf".source = ./themes/tango-dark.conf;

  # test fonts and terminal encoding
  # $ http https://antofthy.gitlab.io/info/data/unicode_examples/UTF-8-demo.txt | less
  # $ http https://unicode.org/Public/emoji/5.0/emoji-test.txt | less

}
