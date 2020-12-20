#!/usr/bin/env bash

set -euo pipefail
set -x

find -iname '*nix' -exec \
     nixfmt -w 79 {} \;
