{ config, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    # $ nix-prefetch-github rycee home-manager --rev master
    rev = "223e3c38a13fb45726c7a9d97e2612ae53ab4f98";
    ref = "master";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
    ./hardware/x1c6.nix
    ./modules/storage.nix
    ./modules/boot.nix
    ./modules/nix.nix
    ./modules/nixpkgs.nix
    ./modules/locale.nix
    ./modules/users.nix
    ./modules/security.nix
    ./modules/power.nix
    ./modules/network.nix
    ./modules/console.nix
    ./modules/xserver.nix
    ./modules/sound.nix
    ./modules/vpn.nix
    #<home-manager/nixos>
  ];

  system = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "19.03";
    autoUpgrade.enable = false;
  };

}
