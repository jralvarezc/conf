{ config, pkgs, ... }:

{

  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; } )
  ];

  environment.systemPackages = with pkgs; [ direnv nix-direnv ];
  
  # nix options for derivations to persist garbage collection
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

}
