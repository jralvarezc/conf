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
   - currently: nix+git

2. Minimal attack surface (less apps, simpler apps, minimal customization)
   - currently: i3+termite+restic

3. Reproducible setup (pinned versions -TODO-, one step build)

4. Safe defaults (rm -i, vpn, encrypted disk and swap, autolock,
frecuent and automatic dedup write only -TODO- backup)
   - current backup: backblaze (not write-only), will be solved with wasabi
   - current vpn: mullvad (without killswitch), will be solver protonvpn2

5. Separation of concerns (nixos-modules to avoid coupling -TODO-)

6. Secrets as code (versioned, encrypted at rest)
   - currently: gnupg+sops+yaml_keys
   - gitcrypt: not encrypted at rest in clonned repo
   - pass: several files and complex git workflow
   - pass+tomb: more tools and same results with sops