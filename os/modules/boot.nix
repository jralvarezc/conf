{ config, pkgs, ...}:

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

  boot.extraModulePackages = [
    config.boot.kernelPackages.wireguard
  ];

}
