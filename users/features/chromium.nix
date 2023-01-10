{ config, lib, pkgs, ... }:

{

  programs.chromium.extensions = [
    "fdjamakpfbbddfjaooikfcpapjohcfmg" # dashlane
    "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # offlinedocs
    "ioalpmibngobedobkmbhgmadaphocjdn" # onelogin
    "niloccemoadcdkdjlinkgdfekeahmflj" # pocket
    "niepjjjfafhadmfdminbckmciijcaagc" # trimless
    "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
  ];

}
