{ config, pkgs, ... }:

{
  boot = {
    tmpOnTmpfs = true;
    cleanTmpDir = true;
  };

  boot.loader.grub = {
    enable = true;
    memtest86.enable = true;
    version = 2;
    enableCryptodisk = true; # first passphrase ask
    device = "/dev/nvme0n1";
  };

  boot.initrd.luks.devices = {
    root = {
      preLVM = true;
      keyFile = "/keyfile.bin"; # using second slot, avoiding passphrase again
      fallbackToPassword = true;
      device = "/dev/nvme0n1p1";
    };
  };

  boot.initrd.secrets = {
    "/keyfile.bin" = "/etc/secrets/initrd/keyfile.bin";
  };

  boot.initrd.supportedFilesystems = ["zfs"]; # boot from zfs
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "25de0137"; # $ head -c 8 /etc/machine-id
}
