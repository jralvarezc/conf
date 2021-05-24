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
    vim
    neovim # tools
    nix-index
    evtest
    acpi
    nano
    vim
    git
    parted
    gptfdisk
    lsof
    qemu
    beep
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
