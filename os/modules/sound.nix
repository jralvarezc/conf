{ config, pkgs, ... }:

{
   sound.enable = true;
   nixpkgs.config.pulseaudio = true;
   hardware.pulseaudio = {
     enable = true;
     support32Bit = true;
   };
}
