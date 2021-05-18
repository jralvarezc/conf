{ config, lib, pkgs, ... }:

{
  # $ sudo systemctl restart wg-quick-mullvad
  networking.wg-quick.interfaces.mullvad = {
    address = [ "10.64.184.7/32" "fc00:bbbb:bbbb:bb01::1:b806/128" ];
    # dns parameter must be commented to combine vpn with dnscrypt
    # dns = [ "193.138.218.74" ];
    privateKeyFile = "/home/ralvarez/secrets/mullvad";
    peers = [
      {
        publicKey = "+30LcSQzgNtB01wyCyh4YPjItVyBFX5TP6Fs47AJSnA=";
        allowedIPs = [ "0.0.0.0/0" "::0/0" ];
        endpoint = "185.209.196.69:51820";
      }
    ];
  };

}
