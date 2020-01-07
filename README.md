# NixOS and Home-Manager Configuration

1. Clone this repo

1. Relocate main config files to allow simple editing as non-admin user (wheel group)
```
$ ./setup.sh
```

1. Change configuration accordingly and rebuild whenever necesary:
```
$ home-manager switch
$ sudo nixos-rebuild switch --upgrade --keep-going
```
