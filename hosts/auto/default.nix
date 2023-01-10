{ config, pkgs, inputs, ... }:

{

  documentation.info.enable = false;

  system = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "19.03";
    autoUpgrade.enable = false;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bd7087d7-6041-4b65-81a8-f88364efe7ab";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/2570bcfb-f35f-4ff9-b6ab-e93d8562b6a5"; }
  ];

  imports = [
    ../features/autologin.nix
    ../features/boot.nix
    ../features/persist.nix
    ../features/nix.nix
    ../features/nixpkgs.nix
    ../features/direnv.nix
    ../features/locale.nix
    ../features/security.nix
    ../features/power.nix
    ../features/network.nix
    #../features/vpn.nix
    ../features/services.nix
    ../features/dns.nix
    ../features/console.nix
    ../features/packages.nix
    ../features/fonts.nix
    ../features/xserver.nix
    ../features/xfonts.nix
    ../features/home.nix
    ../features/wm/i3.nix
    #../features/wm/xmonad
    ../features/sound.nix
  ];

}
