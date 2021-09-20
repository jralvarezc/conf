{ config, lib, pkgs, ... }:

{
  networking = {
    # global dhcp will be deprecated
    useDHCP = false;
    dhcpcd.enable = false;

    # networkd as config backend
    useNetworkd = true;

    hostName = "auto";
    enableIPv6 = true;
    firewall.enable = true;
    wireless.iwd.enable = true;
  };

  # use systemd.networkd instead of network-manager
  # $ man systemd.network
  systemd.network.enable = true;
  systemd.network.networks.wireless = {
    name = "w*";
    DHCP = "yes";
    networkConfig = {
      IPv6AcceptRA = true;
      IPv6PrivacyExtensions = "yes";
    };
    dhcpConfig = {
      Anonymize = true;
      UseHostname = false;
      UseDNS = false;
      UseNTP = false;
    };
  };

  # not working
  programs.captive-browser = {
    enable = true;
    interface = "wlan0";
  };

}
