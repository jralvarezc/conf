{ config, lib, pkgs, ... }:

{

  security = {
    auditd.enable = true;
    sudo.wheelNeedsPassword = false;
  };

}
