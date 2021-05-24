#!/usr/bin/env bash

# https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
# https://nixos.org/manual/nixos/stable/index.html#sec-building-cd

nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
ls result/iso/

# qemu-system-x86_64 -cdrom result/iso/image.iso
# dd if=result/iso/image.iso of=/dev/XXXX
# qemu-system-x86_64 -hda /dev/sdb
# mount -o loop -t iso9660 ./result/iso/image.iso /mnt/iso
