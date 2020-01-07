
* brightness not working
```
#Screen brightness controls Thinkpad X1 Yoga
# sudo apt-get install xbacklight
bindsym XF86MonBrightnessUp exec xbacklight -inc 25
bindsym XF86MonBrightnessDown exec xbacklight -dec 25
```

* organize configuration as modules
https://nixos.wiki/wiki/NixOS:extend_NixOS
https://nixos.wiki/wiki/Module#Function

* json nixpining vs nix pinning
https://gist.github.com/zimbatm/de5350245874361762b6a4dfe5366530

* gitcrypt instead of sops? specially for declarative userpass?
https://github.com/tomberek/nixos.files/blob/master/.gitattributes
https://github.com/tomberek/nixos.files/blob/master/environment.nix#L99

* nix standard project structure
https://www.reddit.com/r/NixOS/comments/8tkllx/standard_project_structure/

* nixos without using channels (and nixpath)
```
https://github.com/anderspapitto/nixos-configuration/
https://github.com/anderspapitto/nixos-configuration/blob/master/nix.nix#L12
https://www.reddit.com/r/NixOS/comments/7p83y4/install_a_package_from_unstable_while_running/
https://nixos.wiki/wiki/How_to_fetch_Nixpkgs_with_an_empty_NIX_PATH
https://github.com/NixOS/nixpkgs/issues/27994
https://www.reddit.com/r/NixOS/comments/deorkq/pinning_nixpkgs_by_sha/
https://github.com/colemickens/nixcfg
https://news.ycombinator.com/item?id=20486462

ralvarez@auto  ~/conf  rg "<nix" .
./os/hardware/x1c6.nix
8:    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

./home/wrappers/restic-b2.nix
1:with import <nixpkgs> {};

./home/packages/tresorit/default.nix
3:with import <nixpkgs> {};

./home/packages/tresorit/release.nix
1:with import <nixpkgs> {};
 ralvarez@auto  ~/conf  nix-channel --list
 ralvarez@auto  ~/conf  sudo nix-channel --list

home-manager https://github.com/rycee/home-manager/archive/master.tar.gz
nixos https://nixos.org/channels/nixos-unstable
 ralvarez@auto  ~/conf  echo $NIX_PATH
/home/ralvarez/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels
```

* notify via dunst where backup is not possible to run because of ggpagent is not open

* should be integrated home and os config?
is there a way to run home-mananger switch using nixos-rebuild

* what is the max temperature?
Jan 02 11:02:26 auto kernel: CPU2: Package temperature above threshold, cpu clock throttled

* wasabi backup in append-only-mode with no prune operations
migrate from restic?

* organize per profile configuration
https://github.com/dnixty/home-config/blob/0eaf92623f3044b9c61114b0a1a012c4d74ec5ae/modules/profiles/gpg.nix
https://github.com/dnixty/nixos-config

* chromium with wrapper in incognito mode, allows remove brave and firefox
https://github.com/floscr/dotfiles-nix/blob/db7c6553736dbce0d74ca763cd1a5e2e9f4bf075/modules/browser/chromium.nix

* move to wayland and swaywm
https://swaywm.org/

* how to create wrappers
https://github.com/leosbotelho/cartons/tree/17a800c848ffc493ca6cbdfd3917fb9fdc673eb1/pkgs/wrappers

* protonvpn now has killswitch support for linux

* wrappers?
https://github.com/JorelAli/nixos/blob/c5bcfb6666be8ea0a2a17a9c50f5dc298c9b949d/overlays/wrappers/dunst.nix

* simpleXService pattern
https://github.com/fiksn/nix/blob/ddde57a1ccc518298012e7a0037b89c86829fb29/nixos/profiles/i3.nix

* nice example of a machine configuration
https://github.com/ktor/nixos/blob/ae6ae065e5052cba158c34b67bcad8419138e345/configuration.nix

* timedoctor
https://unix.stackexchange.com/questions/522822/different-methods-to-run-a-non-nixos-executable-on-nixos

* autoPatchelfHook
https://github.com/NixOS/nixpkgs/commit/1cba74dfc1541673f91b91c3ab50dbdce43c764a
is it applicable to TD? to burp?

* ls --color=always? rg --color always | less
remove most?

* rg ripgrep -2 replaces pcregrep y pcre2grep?

* ciphered brtfs?
https://jappieklooster.nl/nixos-on-encrypted-btrfs.html
https://github.com/shazow/nixfiles/blob/760ed372ce17e68f71381ac2de5f3039798075a3/common/boot.nix

* fzf

* packaging hopenpgp-tools  (not in nixos)
http://hackage.haskell.org/package/hopenpgp-tools

* use nixpkgs.json???
https://github.com/kmein/niveum/blob/master/nixpkgs.json
https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs

* wireguard vpn
https://greycoder.com/a-list-of-wireguard-supporting-vpns-in-2019/
https://github.com/nrhtr/nix-config/blob/master/thinkpad/wireguard.nix

* nixos config file strategies
https://github.com/aaronjanse/dotfiles

* generate vm from config to diff format
https://github.com/nix-community/nixos-generators

* initialHassedPasswords with externalized secrets.nix
https://github.com/sylvblck/nixos-config/blob/f85d5a9a6ce3989a3453cd66f6f91c0a0a03c90a/users/sylv.nix
https://github.com/mfiano/nixos-config/blob/909a4253a16becaad7cc1c50af7d0aca04e58178/cfg/users.nix

* auto-saves emacs
Auto-saving biva.txt: Opening output file: No such file or directory, /home/ralvarez/.emacs.d/auto-saves/#

* EDITOR=emacs

* emacs as a user service in home-manager

* emacs via nix home-manager
https://github.com/BrianHicks/dotfiles.nix/blob/master/dotfiles/emacs.nix

* mkdir /home/ralvarez/.emacs.d/auto-saves (nixify)

* move to home-manager install as user by code
https://github.com/bobvanderlinden/nix-home/blob/master/home.nix

* i3 and git config nixifie

* xscreenlayout nixfied

* several DPI according to monitors (autorandr)

* split xwindows conf from home-manager
https://rycee.net/posts/2017-07-02-manage-your-home-with-nix.html

* mouse bluetooth as code according to identifiers

* devenvs removed from home-manager (default.nix on git)

* printer?

* laptop config
https://github.com/Vodurden/devbox/blob/2cdbb4b2b4fac764bf7e632f70db597f8e6e7dd4/nixos/metabox/configuration.nix

* bootloader efi??

* swap is enabled? is encrypted?
https://github.com/shazow/nixfiles/blob/d0de6f1c68e07f19b4be7584295a16175a05b443/disk.example.nix

* update intel microcode
https://github.com/dejanr/dotfiles/blob/34d40e4d59853f11f3190b2a95589f0e59175294/nix/config/nixpkgs/machines/theory/hardware-configuration.nix

* thinkpad t480 kernel parameters
https://github.com/dejanr/dotfiles/blob/34d40e4d59853f11f3190b2a95589f0e59175294/nix/config/nixpkgs/machines/theory/hardware-configuration.nix

* ideal conf structure
https://github.com/dejanr/dotfiles/blob/34d40e4d59853f11f3190b2a95589f0e59175294/nix/config/nixpkgs/machines/theory/hardware-configuration.nix

* triggerhappy, alternativa a los problemas de actkbd por usuario root lanzando la solicitud
https://github.com/xantoz/nixconfig/blob/64c1fa55e065f31aa9c02c3a05e0124a304008cf/machines/nazrin/configuration.nix

* tmpontmpfs y cleanTmpDir y sysctl
https://github.com/kpango/dotfiles/blob/d8453fe3b3a530292974ca0edd6677066efa4275/nix/boot.nix

* usbguard
https://github.com/lesnuages/dotfiles/blob/70d7174f3b786c49c36ace890f51b2cca328d2e1/configuration.nix

* workflow test same OS conf via iso with qemu

* prelude vs spacemacs
