{ inputs, config, pkgs, ... }:
let
  login = "ralvarez";
in
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./features/persist.nix
  ];

  users.extraUsers."${login}" = {
    createHome = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "disk"
      "networkmanager"
    ];
    group = "users";
    shell = pkgs.zsh;
    home = "/home/" + login;
    isNormalUser = true;
    uid = 1000;
    # Don't forget to set a password with ‘passwd’.
  };

  nix.settings.trusted-users = [ login ];
  services.gnome.gnome-keyring.enable = true;
  home-manager.users."${login}" = import ./home.nix;

}
