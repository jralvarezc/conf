#!/usr/bin/env bash

IFS=$'\n\t'

set -e
set -u
set -o pipefail
set -x

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
    -W UnusedArg \
    -W UnusedLetBind \
    -W UpdateEmptySet \
    -W AlphabeticalArgs \
    -W AlphabeticalBindings \
    -W BetaReduction \
    -W EmptyVariadicParamSet \
    -W UnneededAntiquote \
    -r .

find . -iname "*.sh" -exec \
     shellcheck -o all {} \;
