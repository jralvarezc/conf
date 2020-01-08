# NixOS and Home-Manager Configuration

## Usage

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

## Requirements

1. Secrets as code, always stored encrypted

1. Minimal configuration (less apps, less customization, simpler apps, less code)

1. Reproducible setup (pinned versions, one build step -repo and gpg keys-)

1. Separation of concerns (nixos-modules to avoid coupling -TODO-)

1. Secure defaults (rm -i, vpn per default, encrypted disk and swap, autolock, etc)