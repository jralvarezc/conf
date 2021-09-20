{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    pciutils
    lshw
    inxi
    htop
    ltrace
    file
    tree
    patchelf
    which
    psmisc
    traceroute
    bind
    binutils
    nix-index
    evtest
    acpi
    kakoune
    git
    parted
    gptfdisk
    lsof
    qemu
    beep
    just
  ];

  programs = {
    ssh = {
      startAgent = true;
      extraConfig = ''
        AddKeysToAgent yes
      '';
    };
  };

  programs.gnupg.dirmngr.enable = true;

}
