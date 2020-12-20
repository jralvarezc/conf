{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "auto";
    enableIPv6 = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    firewall.enable = true;
    networkmanager.enable = true;
  };

  services.ssmtp = {
    enable = true;
    hostName = "smtp.gmail.com:587";
  };
}
