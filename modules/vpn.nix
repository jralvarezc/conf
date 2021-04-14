{ config, options, pkgs, lib, ... }:

with lib; {

  options.modules.services.mullvad = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf config.modules.services.mullvad.enable {

    environment.systemPackages = with pkgs; [
      mullvad-vpn
    ];

    boot.extraModulePackages = [
#      config.boot.kernelPackages.wireguard
    ];

    boot.kernelModules = [
      "tun"
    ];

    # https://github.com/NixOS/nixpkgs/issues/91923
    networking.iproute2.enable = true;

    # https://github.com/mullvad/mullvadvpn-app/issues/473
    # networking.nameservers = pkgs.lib.mkForce [ "127.0.0.1" ];

    systemd.services.mullvad-daemon = {
      description = "Mullvad VPN daemon";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network.target" ];
      after = [
        "network-online.target"
        "NetworkManager.service"
        "systemd-resolved.service"
      ];
      path = [
        pkgs.iproute
        # Needed for ping
        "/run/wrappers"
      ];
      serviceConfig = {
        StartLimitBurst = 5;
        StartLimitIntervalSec = 20;
        ExecStart = ''
          ${pkgs.mullvad-vpn}/bin/mullvad-daemon -v
                                               --disable-stdout-timestamps'';
        Restart = "always";
        RestartSec = 1;
      };
    };
  };

}

# Setup commands
# $ mullvad factory-reset
# $ mullvad account set XXXXXXXXXXXXX
# $ mullvad tunnel ipv6 set on
# $ mullvad always-require-vpn set on
# $ mullvad auto-connect set on
# $ mullvad relay set tunnel-protocol wireguard
# $ mullvad relay set location ch # switzerland safe legislation
#
# Working with killswitch,
# For multihop install Proxy Helper in chromium and set
# socks5 proxy us6-wg.socks5.mullvad.net 1080 # usa common exit node
