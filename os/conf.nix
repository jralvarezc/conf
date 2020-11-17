{ config, pkgs, ... }:

let

in
{
  imports = [
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
  ];

  system = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "19.03";
    autoUpgrade.enable = false;
  };

}
