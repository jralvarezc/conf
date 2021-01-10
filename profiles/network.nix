{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "auto";
    enableIPv6 = true;
    firewall.enable = true;
    networkmanager.enable = true;
  };

  services.ssmtp = {
    enable = true;
    hostName = "smtp.gmail.com:587";
  };
}
