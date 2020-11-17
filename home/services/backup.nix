{config, lib, pkgs, ...}:

let
  cmd = pkgs.callPackage ../wrappers/restic-b2.nix {};
in
{
  systemd.user.services.backup = {
    Service.Type = "oneshot";
    Service.ExecStart = ''${cmd}/bin/restic-b2 backup --one-file-system --verbose\
                           --exclude=/home/ralvarez/.cache\
                           --verbose /home/ralvarez'';
  };

  systemd.user.timers.backup = {
    Unit.PartOf = [ "backup.service" ];
    Timer.Unit = "backup.service";
    Timer.OnBootSec = "2h";
    Timer.OnUnitInactiveSec = "8h";
    Install.WantedBy = [ "timers.target" ];
  };

  systemd.user.services.prune = {
    Service.Type = "oneshot";
    Service.ExecStart = ''${cmd} forget --prune --keep-last 1 --keep-within 24h\
                            --keep-daily 7 --keep-weekly 12 --keep-monthly 36\
                            --keep-yearly 15'';
  };

  systemd.user.timers.prune = {
    Unit.PartOf = [ "prune.service" ];
    Timer.Unit = "prune.service";
    Timer.OnCalendar = "weekly";
    Timer.Persistent = true;
    Timer.RandomizedDelaySec = "1h";
    Install.WantedBy = [ "timers.target" ];
  };

}
