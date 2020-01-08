# NixOS and Home-Manager Configuration

## Usage

1. Clone this repo

2. Relocate main config files to allow simple editing as non-admin
user (wheel group)
```
$ ./setup.sh
```

3. Change configuration accordingly and rebuild whenever necesary:
```
$ home-manager switch
$ sudo nixos-rebuild switch --upgrade --keep-going
```

## Requirements

1. Open source by default (public code, auditable, community focused)

2. Minimal attack surface (less apps, simpler apps, minimal customization)

3. Reproducible setup (pinned versions, one step build)

4. Safe defaults (rm -i, vpn, encrypted disk and swap, autolock,
frecuent and automatic dedup backup)

5. Separation of concerns (nixos-modules to avoid coupling -TODO-)

6. Secrets as code (versioned, encrypted at rest)