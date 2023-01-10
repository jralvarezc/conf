{ config, lib, pkgs, modulesPath, inputs, ... }:

{
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
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
