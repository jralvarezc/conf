#!/usr/bin/env bash

set -x

DISK=/dev/sdc

# cryptsetup luksOpen /dev/nvme0n1p1 LAPTOP
# mkdir /LAPTOP
# lsblk
# mount /dev/disk/by-label/nixos /LAPTOP/
# cd /LAPTOP/home/ralvarez/nixusb/

systemctl stop wpa_supplicant.service
wpa_supplicant -B -i wlp2s0 -c <(wpa_passphrase AngelAlvarez5G bx04nj3y)
parted "$DISK" --script mklabel msdos
parted "$DISK" --script mkpart primary 1MiB 100%
mkfs.ext4 -L nixos-usb -F "$DISK"1
mount "$DISK"1 /mnt/
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix
nixos-install

# asking root password
# including configuration.nix with grub.install
# select partition
