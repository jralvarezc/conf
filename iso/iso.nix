# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{config, pkgs, ...}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

#  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  boot.initrd.supportedFilesystems = ["zfs"]; # boot from zfs
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "25de0137"; # $ head -c 8 /etc/machine-id

  # use iwctl
  networking.wireless.enable = false;
  networking.wireless.iwd.enable = true;

  # current bug building the system (possible upstream)
  documentation.info.enable = false;

  environment.systemPackages = with pkgs; [
    fish
  ];

  environment.etc."install.sh" = {
    mode = "0700";
    source = ./install.sh;
  };

  environment.etc."darlings.sh" = {
    mode = "0700";
    source = ./darlings.sh;
  };

}
