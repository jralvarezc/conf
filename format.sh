#!/usr/bin/env bash

IFS=$'\n\t'

set -e
set -u
set -o pipefail
set -x

find . -iname '*nix' -exec \
     nixfmt -w 79 {} \;
