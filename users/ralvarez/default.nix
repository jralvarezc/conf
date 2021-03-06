{ config, pkgs, ... }:
let
  login = "ralvarez";
in
{

  # nixos configuration for user
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

  nix.trustedUsers = [ login ];

  services.xserver.displayManager.autoLogin.user = login;

  # home-manager configuration for user
  home-manager.users."${login}" = import ./home.nix;

}
