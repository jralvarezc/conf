{ config, lib, pkgs, ...}:

{

  # TODO: move to console and xserver features?
  environment.systemPackages = with pkgs; [
    home-manager
    pciutils htop ltrace file patchelf which psmisc traceroute
    bind binutils vim termite # tools
    nix-index nix-prefetch-scripts
    evtest
    xscreensaver i3status i3lock i3blocks dmenu # wm
    dunst libnotify
    font-manager powerline-fonts
    acpi nano vim
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
