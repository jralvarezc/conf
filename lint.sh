#!/usr/bin/env bash

IFS=$'\n\t'

set -e
set -u
set -o pipefail
set -x

# Semantic order is better than lexical
# -W AlphabeticalArgs
# -W AlphabeticalBindings

# NixOS config requires unused args in some files
# -W UnusedArg

nix-linter \
    -W DIYInherit \
    -W EmptyInherit \
    -W EmptyLet \
    -W EtaReduce \
    -W FreeLetInFunc \
    -W LetInInheritRecset \
    -W ListLiteralConcat \
    -W NegateAtom \
    -W SequentialLet \
    -W SetLiteralUpdate \
    -W UnfortunateArgName \
    -W UnneededRec \
    -W UnusedLetBind \
    -W UpdateEmptySet \
    -W BetaReduction \
    -W EmptyVariadicParamSet \
    -W UnneededAntiquote \
    -r .

find . -iname "*.sh" -exec \
     shellcheck -o all {} \;
