{config, lib, pkgs, ... }:

{

  services.dunst = {
    enable = true;
    settings = {
      global = {
        stack_duplicates = false;
        geometry = "365x15-21+21";
        show_age_threshold = 1;
        history_length = 20;
        horizontal_padding = 16;
        indicate_hidden = true;
        padding = 12;
        startup_notification = [ "true" ];
        word_wrap = true;
      };

      shortcuts = {
        close_all = "mod4+shift+a";
        history = "mod4+shift+h";
      };

      urgency_low = {
        background = "#00ff00"; # green
        timeout = 30;
      };

      urgency_normal = {
        background = "#ffff00"; # yellow
        foreground = "#000000"; # black
        timeout = 60;
      };

      urgency_critical = {
        background = "#ff0000"; # red
        timeout = 0;
      };
    };
  };

}
