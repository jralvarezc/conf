{ config, lib, pkgs, ... }:

{

  # harden dns queries, independent of vpn status and type of dns

  networking = {
    resolvconf.useLocalResolver = true;
    nameservers = [ "127.0.0.1" "::1" ];

    # if using nm disable dns change
    networkmanager.dns = "none";
    # if using dhcp disable dns change
    dhcpcd.extraConfig = "nohook resolv.conf";
  };

  # disable systemd resolved to force use of dnscrypt
  services.resolved.enable = false;

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {

      listen_addresses = [ "127.0.0.1:53" ];

      ipv6_servers = true;
      dnscrypt_servers = true;
      doh_servers = true;

      block_unqualified = true;
      block_undelegated = true;
      force_tcp = false;

      require_nolog = true;
      require_dnssec = true;
      require_nofilter = true;

      sources = {
        public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/dnscrypt-resolvers/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          refresh_delay = 71;
        };

        relays = {
          urls = [
            "https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/relays.md"
            "https://download.dnscrypt.info/dnscrypt-resolvers/v3/relays.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/relays.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          refresh_delay = 71;
        };
      };

      # if everything else fails, ignore system and then cloudflare
      ignore_system_dns = true;
      fallback_resolvers = [ "1.1.1.1:53" ];

    };
  };

  # dnsmasq is not needed because dnscrypt-proxy is able to do caching

  # DNS tests URLs
  # https://dnssec.vs.uni-due.de/
  # https://dnsleaktest.com/
  # https://cmdns.dev.dns-oarc.net/
  # https://rootcanary.org/test.html
  # http://entropy.dns-oarc.net/test/
  # https://www.grc.com/dns/dns.htm

}
