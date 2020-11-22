{ config, lib, pkgs, ...}:

{
  console = {
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };

  environment.systemPackages = with pkgs; [
    home-manager
    pciutils htop ltrace file patchelf which psmisc traceroute
    bind binutils vim # tools
    nix-index
    evtest
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
