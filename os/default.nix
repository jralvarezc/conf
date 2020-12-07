{ config, pkgs, ... }:

{
  imports = [
    ./hardware/x1c6.nix
    ./profiles/storage.nix
    ./profiles/boot.nix
    ./profiles/nix.nix
    ./profiles/nixpkgs.nix
    ./profiles/locale.nix
    ./profiles/users.nix
    ./profiles/security.nix
    ./profiles/power.nix
    ./profiles/network.nix
    ./profiles/console.nix
    ./profiles/xserver.nix
    ./profiles/wm/i3
#    ./profiles/wm/xmonad
    ./profiles/sound.nix
    ./modules/vpn/mullvad
  ];

  system = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "19.03";
    autoUpgrade.enable = false;
  };

}
