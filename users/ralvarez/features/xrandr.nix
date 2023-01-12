{ config, lib, pkgs, ... }:

{

  home.file.".local/bin/xrandr-two" = {
    text = ''
      #!/usr/bin/env bash
      xrandr --output eDP-1 \
               --mode 2560x1440 \
               --pos 712x1600 \
               --rotate normal \
               --primary \
             --output DP-2 \
               --mode 3840x1600 \
               --pos 0x0 \
               --rotate normal \
             --output DP-1 --off \
             --output HDMI-1 --off \
             --output HDMI-2 --off
    '';
    executable = true;
  };

}
