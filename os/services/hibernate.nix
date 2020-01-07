{config, lib, pkgs, ...}:

# Thinkpad X1C6 battery does not notify discharging events via udev
# Polling each minute to notify if BAT<10% and hibernate if BAT<2%
{
  systemd.user.timers.hibernate = {
    timerConfig.OnBootSec = "5m";
    timerConfig.OnUnitInactiveSec = "1m";
    timerConfig.Unit = "hibernate.service";
    wantedBy = [ "timers.target" ];
    partOf = [ "hibernate.service" ];
  };

  systemd.user.services.hibernate = {
    serviceConfig.PassEnvironment = "DISPLAY";
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.acpi}/bin/acpi -b | ${pkgs.gawk}/bin/awk -F'[,:%]' '{print $2, $3}' | {
	      read -r STATUS CAPACITY

	      if [ "$STATUS" = Discharging -a "$CAPACITY" -lt 10 ]; then
          ${pkgs.libnotify}/bin/notify-send --urgency=critical \
            "Critical battery threshold <10%. Connect to AC NOW"
	      fi
	      if [ "$STATUS" = Discharging -a "$CAPACITY" -lt 2 ]; then
		      systemctl hibernate
	      fi

      }
      '';
  };

}

# After change you need to manually restart the service
# $ systemctl disable hibernate --user && systemctl enable hibernate --user
