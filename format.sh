#!/usr/bin/env bash

set -x

find -iname '*nix' -exec \
     nixfmt -w 79 {} \;
