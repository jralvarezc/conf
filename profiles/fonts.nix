{ config, lib, pkgs, ... }:

{

  console = {
    font = "ter-i32b";
    packages = with pkgs; [
      terminus_font
    ];
  };

  environment.systemPackages =
    let
      nerdfonts-jbm = pkgs.nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      };
    in
    [
      nerdfonts-jbm
    ];

}
