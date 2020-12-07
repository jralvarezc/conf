#!/usr/bin/env bash

set -x

nix-collect-garbage -d
sudo nix-collect-garbage -d
