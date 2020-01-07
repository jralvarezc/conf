{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.mullvad;

  mullvadService = cfg:
  {
    description = "Mullvad VPN daemon";
    after = [ "network.target"
              "network-online.target"
              "NetworkManager.service"
              "systemd-resolved.service"];

    path = with pkgs; [ iproute utillinux coreutils ];

    unitConfig = {
       StartLimitBurst = 5;
       StartLimitIntervalSec = 20;
    };

    serviceConfig = {
       Restart = "always";
       RestartSec = 1;
       ExecStart = "${pkgs.mullvad-vpn}/bin/mullvad-daemon
                                       -v --disable-stdout-timestamps";
    };
    wantedBy = [ "multi-user.target" ];
  };

  mullvadConfig = {
    enable = mkEnableOption "Mullvad VPN server";
  };

in

{
  options = {
    services.mullvad = mullvadConfig;
  };

  config = mkIf (cfg.enable) {
    systemd.services.mullvad = mullvadService cfg;
  };

}
