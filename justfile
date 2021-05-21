@_default:
  just --list --unsorted

all: format update clean

update:
  @echo "[INFO] Updating flake..."
  nix flake update

build:
  @echo "[INFO] Rebuilding NixOS..."
  doas nixos-rebuild --flake .#auto switch

clean max-age="30":
  @echo "[INFO] Deleting user and system garbage..."
  nix profile list | awk '{print $NF}' | xargs nix profile remove
  doas nix profile list | awk '{print $NF}' | doas xargs nix profile remove
  nix-collect-garbage --delete-older-than {{max-age}}d
  doas nix-collect-garbage --delete-older-than {{max-age}}d
  git gc --aggressive

size:
  @echo "[INFO] Calculating size..."
  du . -sh --exclude=.git
  tokei . -s code

format:
  @echo "[INFO]: Formating all nix files..."
  find . -iname '*.nix' -exec nixpkgs-fmt {} \;

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

search pkg:
  @echo "[INFO] Searching package {{pkg}}..."
  nix search nixpkgs '\.{{pkg}}$'

run pkg:
  @echo "[INFO] Running package {{pkg}}..."
  nix run nixpkgs#{{pkg}}