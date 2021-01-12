{ config, lib, pkgs, ... }:

{

  console = {
    font = "ter-i32b";
    packages = with pkgs; [
      terminus_font
    ];
  };

}
