@_default:
  just --list --unsorted

all: format update clean

update:
  @echo "[INFO] Updating flake and rebuilding OS..."
  nix flake update --recreate-lock-file
  sudo nixos-rebuild --flake .#auto switch

clean max-age="30":
  @echo "[INFO] Deleting user and system garbage..."
  nix-collect-garbage --delete-older-than {{max-age}}d
  sudo nix-collect-garbage --delete-older-than {{max-age}}d

format:
  @echo "[INFO]: Formating all nix files..."
  find . -iname '*.nix' -exec nixfmt -w 79 {} \;

lint:
  @echo "[INFO]: Linting all nix files..."
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

search pkg="mutt":
  @echo "[INFO] Searching package {{pkg}}..."
  nix search nixpkgs '\.{{pkg}}$'

run pkg="mutt":
  @echo "[INFO] Running package {{pkg}}..."
  nix run nixpkgs#{{pkg}}