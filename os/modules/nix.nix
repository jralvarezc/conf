{ config, lib, pkgs, inputs, ...}:

{
  nix = {

    # flake support
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    registry.nixpkgs.flake = inputs.nixpkgs;

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    maxJobs = lib.mkDefault 8;

    gc = {
      automatic = true;
      dates = "weekly";
    };

    autoOptimiseStore = true;

    trustedUsers = [ "root" "ralvarez" ];
  };

}
