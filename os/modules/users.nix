{ config, pkgs, ...}:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ralvarez = {
    createHome = true;
    extraGroups = ["wheel" "video" "audio" "disk" "networkmanager"];
    group = "users";
    shell = pkgs.zsh;
    home = "/home/ralvarez";
    isNormalUser = true;
    uid = 1000;
  };
}
