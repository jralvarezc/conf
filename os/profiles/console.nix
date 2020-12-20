{ config, lib, pkgs, ... }:

{
  console.earlySetup = true;

  environment.systemPackages = with pkgs; [
    pciutils
    htop
    ltrace
    file
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
