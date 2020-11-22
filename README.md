# NixOS and Home-Manager Configuration

"Doing anything in Nix causes me untold pain and suffering, and wastes absurd
amounts of my time … unless it follows a path already well-trodden by me
personally. I put myself through this because I know that, after all the pain,
suffering and wasted time, if eventually I reach my destination, I will have a
robust, reliable, reusable solution which will save me even more pain,
suffering and time in the long run." Jacek Generowicz


## Usage

1. Clone this repo

2. Relocate main config files to allow simple editing as non-admin
user (wheel group)
```
$ ./setup.sh
```

3. Nix flake update
```
$ nix flake update --recreate-lock-file
```

4. Change configuration accordingly and rebuild whenever necesary:
```
$ cd conf
$ sudo nixos-rebuild --flake .#auto switch
```

5. Garbage collection (from time to time)
```
$ nix-collect-garbage -d && sudo nix-collect-garbage -d
```

## Goals

1. Open source by default (public code, auditable, community focused)
   - currently: nix+git+github(this repo)

2. Minimal attack surface (less apps, simpler apps, minimal customization)
   - currently: i3+kitty+restic (800 LOC)
```
$ nix-shell -p cloc --run "cloc conf"
cloc conf
      38 text files.
      38 unique files.
      15 files ignored.

github.com/AlDanial/cloc v 1.84  T=0.07 s (342.7 files/s, 15241.4 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Nix                             21            123             32            584
Markdown                         2             93              0            244
YAML                             1              1              0             30
Bourne Shell                     1              1              0              4
-------------------------------------------------------------------------------
SUM:                            25            218             32            862
-------------------------------------------------------------------------------
```

3. Reproducible setup (pinned versions, one step build)
   - currently: flakes
   - nix pinning: difficult to maintain
   - channels: impure

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
   - currently: using modules for os configuration
   - pending: apply same stratety for home-manager
   - past: everything in one file

10. Keyboard centric

## Contradictions

1. Emacs vs Vi regarding requirement of minimal attack surface (less apps,
simpler apps)

1. Monorepo for conf and blog will be a simpler configuration