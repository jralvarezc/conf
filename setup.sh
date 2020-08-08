#!/usr/bin/env bash

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.$$
sudo ln -s "$HOME"/conf/os/conf.nix /etc/nixos/configuration.nix
ls -al /etc/nixos/configuration.nix
