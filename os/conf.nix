{ config, pkgs, ... }:

{
  imports = [
    ./hardware/x1c6.nix
    ./services/vpn.nix
    ./services/hibernate.nix
    <home-manager/nixos>
  ];

  hardware.bluetooth.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  system = {
    stateVersion = "19.03";
    autoUpgrade.enable = false;
  };

  boot = {
    tmpOnTmpfs = true;
    cleanTmpDir = true;
  };

  boot.loader.grub = {
    enable = true;
    memtest86.enable = true;
    version = 2;
    enableCryptodisk = true; # first passphrase ask
    extraInitrd = "/boot/initrd.keys.gz"; # decrypting second slot
    device = "/dev/nvme0n1";
  };

  boot.initrd.luks.devices = {
    root = {
      preLVM = true;
      keyFile = "/keyfile.bin"; # using second slot, avoiding passphrase again
      fallbackToPassword = true;
      device = "/dev/nvme0n1p1";
    };
  };

  boot.extraModulePackages = [
    config.boot.kernelPackages.wireguard
  ];

  console = {
    font = "ter-i32b";
    keyMap = "us";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };

  i18n = {
     defaultLocale = "en_US.UTF-8";
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    autoOptimiseStore = true;
    trustedUsers = [ "root" "ralvarez" ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = false;
  nixpkgs.config.pulseaudio = true;

  time.timeZone = "America/Bogota";

  networking = {
    hostName = "auto";
    enableIPv6 = true;
    nameservers = ["1.1.1.1" "1.0.0.1"];
    firewall.enable = true;
    networkmanager.enable = true;
  };

  services.dnscrypt-proxy.enable = true;
  services.mullvad.enable = true;
  services.ssmtp = {
    enable = true;
    hostName = "smtp.gmail.com:587";
  };

  services.tlp.enable = true;

  services.logind = {
    lidSwitch = "hibernate";
    lidSwitchExternalPower = "ignore";
  };

  security.sudo.wheelNeedsPassword = false;

  fonts = {
    fonts = [ pkgs.google-fonts ];
    fontconfig.dpi = 135; # 135?
  };

  environment.systemPackages = with pkgs; [
    home-manager
    pciutils htop ltrace file patchelf which psmisc traceroute
    bind binutils vim termite # tools
    nix-index nix-prefetch-scripts
    evtest
    xscreensaver i3status i3lock i3blocks dmenu # wm
    dunst libnotify
    font-manager powerline-fonts
    acpi
#    cachix
  ];

  services.printing.enable = true;
  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # Enable touchpad

    displayManager.lightdm.autoLogin = {
      enable = true; # avoiding third passphrase asked
      user = "ralvarez";
    };

    displayManager.defaultSession = "none+i3";

    windowManager = {
      i3.enable = true;
    };

    xautolock = {
      enable = true;
      locker = "${pkgs.i3lock}/bin/i3lock -f -c 000000";
      time = 3;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ralvarez = {
    createHome = true;
    extraGroups = ["wheel" "video" "audio" "disk" "networkmanager"];
    group = "users";
    shell = pkgs.zsh;
    home = "/home/ralvarez";
    isNormalUser = true;
    uid = 1000;
  };

  programs = {
    ssh = {
      startAgent = true;
      extraConfig = ''
        AddKeysToAgent yes
      '';
    };
  };

  programs.gnupg.dirmngr.enable = true;

}
