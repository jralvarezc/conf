{ config, lib, pkgs, inputs, ... }:

{
  nix = {

    # flake support
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    registry.nixpkgs.flake = inputs.nixpkgs;

    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
    ];

    settings = {
      sandbox = true;
      max-jobs = lib.mkDefault 8;
      auto-optimise-store = true;
      trusted-users = [
        "root"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
    };

  };

}
