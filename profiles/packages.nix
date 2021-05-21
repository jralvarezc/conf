{ config, lib, pkgs, ... }:

{

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
    git
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
