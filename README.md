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
   - currently: nix+git+github(this repo)

2. Minimal attack surface (less apps, simpler apps, minimal customization)
   - currently: i3+termite+restic (800 LOC)
```
$ nix-shell -p cloc --run "cloc conf"
      25 text files.
      25 unique files.
      10 files ignored.

github.com/AlDanial/cloc v 1.84  T=0.01 s (1604.0 files/s, 99747.4 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Nix                             12            106             15            600
Markdown                         2             73              0            161
YAML                             1              1              0             30
Bourne Shell                     1              2              0              7
-------------------------------------------------------------------------------
SUM:                            16            182             15            798
-------------------------------------------------------------------------------
```

3. Reproducible setup (pinned versions -TODO-, one step build)
   - currently: using nix-channels
   - future: remove NIX_PATH and versioned nixpkgs

4. Safe defaults (rm -i, vpn, encrypted disk and swap, autolock,
frecuent and automatic dedup write-only backup)
   - current backup: restic (dedup), tresorit (filesync with mobile)
   - current storage: backblaze (not write-only), will be solved with wasabi
   - current vpn: mullvad (without killswitch), will be solved protonvpn2
   - current browser: chromium+plugins, brave not working with plugins

5. Secrets as code (versioned, encrypted at rest)
   - currently: gnupg+sops+yaml_keys
   - gitcrypt: not encrypted at rest in clonned repo
   - pass: several files and complex git workflow
   - pass+tomb: more tools and same results with sops

6. Declarative and avoid of imperative configuration
   - currently: some nix-env installations are used -TODO-
   - future: always destroyed nix-env generations

7. Functional programming
   - currently: NixEL+Nixpkgs+NixOS+Home-Manager

8. Easy to use (sexy security)
   - currently: grub password but not at login, long timeouts for gpg-agent

9. Separation of concerns (one functionality needs multiple touch points)
   - currently: just os and home manager separation
   - future nixos modules to avoid coupling

10. Keyboard centric

## Contradictions

1. Emacs vs Vi regarding requirement of minimal attack surface (less apps,
simpler apps)