{ config, pkgs, ... }:

{

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Hack"
        ];
      })
    ];

    fontconfig = {
      enable = true;
      dpi = 135;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Hack" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Slab" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    font-manager
    powerline-fonts
  ];

  # list installed fonts
  # $ fc-list | cut -f2 -d: | sort -u  | less

}
