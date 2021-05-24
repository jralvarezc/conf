#!/usr/bin/env bash

#
# NixOS install script synthesized from:
#
#   - Erase Your Darlings (https://grahamc.com/blog/erase-your-darlings)
#   - ZFS Datasets for NixOS (https://grahamc.com/blog/nixos-on-zfs)
#   - NixOS Manual (https://nixos.org/nixos/manual/)
#
# It expects the name of the block device (e.g. 'sda') to partition
# and install NixOS on. The script must also be executed as root.
#
# Example: `sudo ./install-darlings.sh sdb
#

set -euo pipefail

################################################################################

export COLOR_RESET="\033[0m"
export RED_BG="\033[41m"
export BLUE_BG="\033[44m"

function err {
    echo -e "${RED_BG}$1${COLOR_RESET}"
}

function info {
    echo -e "${BLUE_BG}$1${COLOR_RESET}"
}

################################################################################

export DISK=$1
#export SWAP_AMT=$2

if ! [[ -v DISK ]]; then
    err "Missing argument. Expected block device name, e.g. 'sda'"
    exit 1
fi

#if ! [[ -v SWAP_AMT ]]; then
#    err "Missing argument. Expected size to use for swap, e.g. '16G'"
#    exit 1
#fi

export DISK_PATH="/dev/${DISK}"

if ! [[ -b "$DISK_PATH" ]]; then
    err "Invalid argument: '${DISK_PATH}' is not a block special file"
    exit 1
fi

if [[ "$EUID" > 0 ]]; then
    err "Must run as root"
    exit 1
fi

export ZFS_POOL="rpool"

# ephemeral datasets
export ZFS_LOCAL="${ZFS_POOL}/local"
export ZFS_DS_ROOT="${ZFS_LOCAL}/root"
export ZFS_DS_NIX="${ZFS_LOCAL}/nix"

# persistent datasets
export ZFS_SAFE="${ZFS_POOL}/safe"
export ZFS_DS_HOME="${ZFS_SAFE}/home"
export ZFS_DS_PERSIST="${ZFS_SAFE}/persist"

export ZFS_BLANK_SNAPSHOT="${ZFS_DS_ROOT}@blank"

################################################################################

info "Running the Legacy partitioning ..."
parted "$DISK_PATH" --script mklabel msdos
#parted "$DISK_PATH" --script mkpart primary ext4 1MiB 512MiB
#parted "$DISK_PATH" --script set 1 boot on
parted "$DISK_PATH" --script mkpart primary 0% 100%
#export DISK_PART_BOOT="${DISK_PATH}1"
export DISK_PART_LUKS="${DISK_PATH}1"

#info "Formatting boot partition ..."
#mkfs.fat -F 32 -n boot "$DISK_PART_BOOT"

info "Setting up LUKS ..."
export LUKS_PV_NAME="nixos-enc"
export LUKS_PV_PATH="/dev/mapper/${LUKS_PV_NAME}"
export LUKS_VG_NAME="nixos-vg"
export LUKS_VG_PATH="/dev/${LUKS_VG_NAME}"

cryptsetup luksFormat "${DISK_PART_LUKS}"
cryptsetup luksOpen "${DISK_PART_LUKS}" "${LUKS_PV_NAME}"

pvcreate "${LUKS_PV_PATH}"
vgcreate "${LUKS_VG_NAME}" "${LUKS_PV_PATH}"

#info "LUKS: Creating ${SWAP_AMT} swap partition ..."
#lvcreate -L "${SWAP_AMT}" -n swap "${LUKS_VG_NAME}"

#export DISK_PART_SWAP="${LUKS_VG_PATH}/swap"
#mkswap -L swap "${DISK_PART_SWAP}"
#swapon "${DISK_PART_SWAP}"

info "LUKS: Using rest of space for root partion ..."
lvcreate -l 100%FREE -n root "${LUKS_VG_NAME}"

export DISK_PART_ROOT="${LUKS_VG_PATH}/root"

info "Creating '$ZFS_POOL' ZFS pool for '$DISK_PART_ROOT' ..."
zpool create -f "$ZFS_POOL" "$DISK_PART_ROOT"

info "Enabling compression for '$ZFS_POOL' ZFS pool ..."
zfs set compression=on "$ZFS_POOL"

info "Creating '$ZFS_DS_ROOT' ZFS dataset ..."
zfs create -p -o mountpoint=legacy "$ZFS_DS_ROOT"

info "Configuring extended attributes setting for '$ZFS_DS_ROOT' ZFS dataset ..."
zfs set xattr=sa "$ZFS_DS_ROOT"

info "Configuring access control list setting for '$ZFS_DS_ROOT' ZFS dataset ..."
zfs set acltype=posixacl "$ZFS_DS_ROOT"

info "Creating '$ZFS_BLANK_SNAPSHOT' ZFS snapshot ..."
zfs snapshot "$ZFS_BLANK_SNAPSHOT"

info "Mounting '$ZFS_DS_ROOT' to /mnt ..."
mount -t zfs "$ZFS_DS_ROOT" /mnt

#info "Mounting '$DISK_PART_BOOT' to /mnt/boot ..."
#mkdir /mnt/boot
#mount -t vfat "$DISK_PART_BOOT" /mnt/boot

info "Creating '$ZFS_DS_NIX' ZFS dataset ..."
zfs create -p -o mountpoint=legacy "$ZFS_DS_NIX"

info "Disabling access time setting for '$ZFS_DS_NIX' ZFS dataset ..."
zfs set atime=off "$ZFS_DS_NIX"

info "Mounting '$ZFS_DS_NIX' to /mnt/nix ..."
mkdir /mnt/nix
mount -t zfs "$ZFS_DS_NIX" /mnt/nix

info "Creating '$ZFS_DS_HOME' ZFS dataset ..."
zfs create -p -o mountpoint=legacy "$ZFS_DS_HOME"

info "Mounting '$ZFS_DS_HOME' to /mnt/home ..."
mkdir /mnt/home
mount -t zfs "$ZFS_DS_HOME" /mnt/home

info "Creating '$ZFS_DS_PERSIST' ZFS dataset ..."
zfs create -p -o mountpoint=legacy "$ZFS_DS_PERSIST"

info "Mounting '$ZFS_DS_PERSIST' to /mnt/persist ..."
mkdir /mnt/persist
mount -t zfs "$ZFS_DS_PERSIST" /mnt/persist

info "Permit ZFS auto-snapshots on ${ZFS_SAFE}/* datasets ..."
zfs set com.sun:auto-snapshot=true "$ZFS_DS_HOME"
zfs set com.sun:auto-snapshot=true "$ZFS_DS_PERSIST"

info "Creating persistent directory for host SSH keys ..."
mkdir -p /mnt/persist/etc/ssh

info "Generating NixOS configuration (/mnt/etc/nixos/*.nix) ..."
nixos-generate-config --root /mnt

info "Enter password for the root user ..."
ROOT_PASSWORD_HASH="$(mkpasswd -m sha-512 | sed 's/\$/\\$/g')"

info "Enter personal user name ..."
read USER_NAME

info "Enter password for '${USER_NAME}' user ..."
USER_PASSWORD_HASH="$(mkpasswd -m sha-512 | sed 's/\$/\\$/g')"

info "Moving generated hardware-configuration.nix to /persist/etc/nixos/ ..."
mkdir -p /mnt/persist/etc/nixos
mv /mnt/etc/nixos/hardware-configuration.nix /mnt/persist/etc/nixos/

info "Backing up the originally generated configuration.nix to /persist/etc/nixos/configuration.nix.original ..."
mv /mnt/etc/nixos/configuration.nix /mnt/persist/etc/nixos/configuration.nix.original

info "Backing up the this installer script to /persist/etc/nixos/install.sh.original ..."
cp "$0" /mnt/persist/etc/nixos/install.sh.original

info "Writing NixOS configuration to /persist/etc/nixos/ ..."
cat <<EOF > /mnt/persist/etc/nixos/configuration.nix
{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];
  nix.nixPath =
    [
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "nixos-config=/persist/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

  # Use grub and legacy bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.devices = [ "${DISK_PATH}" ];

  # source: https://grahamc.com/blog/erase-your-darlings
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r ${ZFS_BLANK_SNAPSHOT}
  '';

  # TODO: grub doesnt find lvm
  boot.initrd.luks.devices = {
    root = {
      device = "${DISK_PART_LUKS}";
      preLVM = true;
      fallbackToPassword = true;
    };
  };

  # source: https://grahamc.com/blog/nixos-on-zfs
  boot.kernelParams = [ "elevator=none" ];
  networking.hostId = "$(head -c 8 /etc/machine-id)";

  networking.networkmanager.enable = false;
  networking.wireless.iwd.enable = true;

  environment.systemPackages = with pkgs;
    [
      git
      tree
    ];

  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
    # TODO: autoReplication
  };

  users = {
    mutableUsers = false;
    users = {
      root = {
        initialHashedPassword = "${ROOT_PASSWORD_HASH}";
      };
      ${USER_NAME} = {
        createHome = true;
        initialHashedPassword = "${USER_PASSWORD_HASH}";
	extraGroups = [ "wheel" "networkmanager" ];
	group = "users";
	uid = 1000;
	home = "/home/${USER_NAME}";
	useDefaultShell = true;
        openssh.authorizedKeys.keys = [ ];
        isNormalUser = true;
      };
    };
  };

  system.stateVersion = "20.03";
}
EOF

info "Installing NixOS to /mnt ..."
ln -s /mnt/persist/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.nix
# already prompted for and configured password
nixos-install -I "nixos-config=/mnt/persist/etc/nixos/configuration.nix" --no-root-passwd
