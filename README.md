# NixOS and Home-Manager Configuration

"Doing anything in Nix causes me untold pain and suffering, and wastes absurd
amounts of my time … unless it follows a path already well-trodden by me
personally. I put myself through this because I know that, after all the pain,
suffering and wasted time, if eventually I reach my destination, I will have a
robust, reliable, reusable solution which will save me even more pain,
suffering and time in the long run." Jacek Generowicz


## Usage

1. Clone this repo

2. Update, rebuild, switch and clean
```
$ ./update.sh
```

3. Search for software:
```
$ nix search nixpkgs '\.mutt$'
```

4. Test new software without installing it:
```
$ nix run nixpkgs#mutt
```

## Goals

1. Open source by default (public code, auditable, community focused)
   - currently: nix+git+github(this repo)

2. Minimal attack surface (less apps, simpler apps, minimal customization)
   - currently: i3+kitty+restic (800 LOC)
```
$ nix run nixpkgs#tokei .
===============================================================================
 Language            Files        Lines         Code     Comments       Blanks
===============================================================================
 Haskell                 1            7            5            1            1
 Markdown                2          390            0          283          107
 Nix                    36          948          685           86          177
 Shell                   2           38           29            4            5
 YAML                    1           31           30            0            1
===============================================================================
 Total                  42         1414          749          374          291
===============================================================================
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