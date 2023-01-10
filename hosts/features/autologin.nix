{ config, pkgs, ... }:

{

  # avoiding third passphrase asked
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "ralvarez";
  };

}
