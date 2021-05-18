{ config, lib, pkgs, ... }:

{

  services.ssmtp = {
    enable = true;
    hostName = "smtp.gmail.com:587";
  };

}
