{ config, pkgs, ... }:

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
    ../profiles/boot.nix
    ../profiles/nix.nix
    ../profiles/nixpkgs.nix
    ../profiles/direnv.nix
    ../profiles/locale.nix
    ../profiles/security.nix
    ../profiles/power.nix
    ../profiles/network.nix
    #../profiles/vpn.nix
    ../profiles/services.nix
    ../profiles/dns.nix
    ../profiles/console.nix
    ../profiles/packages.nix
    ../profiles/fonts.nix
    ../profiles/xserver.nix
    ../profiles/xfonts.nix
    ../profiles/home.nix
    ../profiles/wm/i3.nix
    #../profiles/wm/xmonad
    ../profiles/sound.nix
  ];

}
