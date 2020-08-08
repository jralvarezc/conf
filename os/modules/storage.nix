{ config, lib, pkgs, ...}:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bd7087d7-6041-4b65-81a8-f88364efe7ab";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2570bcfb-f35f-4ff9-b6ab-e93d8562b6a5"; }
    ];

}
