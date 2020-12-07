{ config, lib, pkgs, ...}:

{
  security = {
    auditd.enable = true;
    hideProcessInformation = true;
    sudo.wheelNeedsPassword = false;
  };
}
