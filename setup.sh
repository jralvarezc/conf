#!/usr/bin/env bash

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.$$
sudo ln -s "$HOME"/conf/os/conf.nix /etc/nixos/configuration.nix
ls -al /etc/nixos/configuration.nix

mv "$HOME"/.config/nixpkgs/home.nix "$HOME"/.config/nixpkgs/home.nix.$$
ln -s "$HOME"/conf/home/conf.nix "$HOME"/.config/nixpkgs/home.nix
ls -al "$HOME"/.config/nixpkgs/home.nix
