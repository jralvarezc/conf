{config, lib, pkgs, ... }:

{

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 86400; # 24 hours
    maxCacheTtl = 604800; # 1 week
    extraConfig = "pinentry-program ${pkgs.pinentry}/bin/pinentry";
    # echo RELOADAGENT | gpg-connect-agent
  };

}
