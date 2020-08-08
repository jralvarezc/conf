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
$ sudo nixos-rebuild switch --upgrade --keep-going
```

## Goals

1. Open source by default (public code, auditable, community focused)
   - currently: nix+git+github(this repo)

2. Minimal attack surface (less apps, simpler apps, minimal customization)
   - currently: i3+termite+restic (800 LOC)
```
$ nix-shell -p cloc --run "cloc conf"
      30 text files.
      30 unique files.
       7 files ignored.

github.com/AlDanial/cloc v 1.86  T=0.02 s (1575.5 files/s, 70767.2 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Nix                             20            111             30            571
Markdown                         2             91              0            239
YAML                             1              1              0             30
Bourne Shell                     1              1              0              4
-------------------------------------------------------------------------------
SUM:                            24            204             30            844
-------------------------------------------------------------------------------
```

3. Reproducible setup (pinned versions -TODO-, one step build)
   - currently: using nix-channels (for nixos and nixpkgs) but pinned home-manager
   - future: remove NIX_PATH and versioned nixpkgs
   - nixflakes?

4. Safe defaults (rm -i, vpn, encrypted disk and swap, autolock,
frecuent and automatic dedup write-only backup)
   - current backup: restic (dedup), tresorit (filesync with mobile)
   - current storage: backblaze (not write-only), will be solved with wasabi
   - current vpn: mullvad (multihop with socks5 and killswitch), proton too slow
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
   - currently: basic concerns using simple inclusion
   - future nixos modules with parameters and enable flags

10. Keyboard centric

## Contradictions

1. Emacs vs Vi regarding requirement of minimal attack surface (less apps,
simpler apps)

1. Monorepo for conf and blog will be a simpler configuration