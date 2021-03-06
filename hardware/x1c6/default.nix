{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
  ];

  boot = {
    initrd = {

      kernelModules = [
        "kvm-intel"
        "acpi"
        "thinkpad-acpi"
        "acpi-call"
      ];

      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
    };

    extraModulePackages = [
      config.boot.kernelPackages.acpi_call
    ];

    extraModprobeConfig = "options thinkpad_acpi experimental=1 fan_control=1";
  };

  hardware.bluetooth.enable = true;

}
