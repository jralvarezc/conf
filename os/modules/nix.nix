{ config, lib, pkgs, ...}:

{
  nix = {

    # flake support
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    maxJobs = lib.mkDefault 8;

    gc = {
      automatic = true;
      dates = "weekly";
    };

    autoOptimiseStore = true;

    trustedUsers = [ "root" "ralvarez" ];
  };

}
