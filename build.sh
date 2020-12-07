#!/usr/bin/env bash

set -x

nix flake update --recreate-lock-file
sudo nixos-rebuild --flake .#auto switch
