{ config, pkgs, ... }:

{

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Hack"
          "Iosevka"
          "Terminus"
          "Overpass"
          "JetBrainsMono"
          "SourceCodePro" # provides SauceCodePro
        ];
      })
    ];

    fontconfig = {
      enable = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Hack" ];
        sansSerif = [ "Iosevka" ];
        serif = [ "Iosevka" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    font-manager
    powerline-fonts
  ];

  # list installed fonts
  # $ fc-list | cut -f2 -d: | sort -u  | grep Nerd

}
