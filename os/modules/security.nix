{ config, lib, pkgs, ...}:

{
  security = {
    auditd.enable = true;
    protectKernelImage = true;
    hideProcessInformation = true;
    sudo.wheelNeedsPassword = false;
  };
}
