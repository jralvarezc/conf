{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot = {
    initrd = {
      kernelModules = [ "kvm-intel" "acpi" "thinkpad-acpi" "acpi-call" ];
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    };
    extraModulePackages = [ config.boot.kernelPackages.acpi_call ];
    extraModprobeConfig = "options thinkpad_acpi experimental=1 fan_control=1";
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bd7087d7-6041-4b65-81a8-f88364efe7ab";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2570bcfb-f35f-4ff9-b6ab-e93d8562b6a5"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware.bluetooth.enable = true;

}
