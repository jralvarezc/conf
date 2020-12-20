{ config, lib, pkgs, inputs, ... }:

{
  nix = {

    # flake support
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';

    registry.nixpkgs.flake = inputs.nixpkgs;

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    maxJobs = lib.mkDefault 8;

    useSandbox = true;

    gc = {
      automatic = true;
      dates = "weekly";
    };

    autoOptimiseStore = true;

    trustedUsers = [ "root" "ralvarez" ];
  };

}
