#!/usr/bin/env bash

IFS=$'\n\t'

set -e
set -u
set -o pipefail
set -x

# update
nix flake update --recreate-lock-file
sudo nixos-rebuild --flake .#auto switch

# clean
MAX_AGE="30d"
nix-collect-garbage --delete-older-than "${MAX_AGE}"
sudo nix-collect-garbage --delete-older-than "${MAX_AGE}"
