{ pkgs ? import <nixpkgs> { }, ... }:

with pkgs;

mkShell {

  buildInputs = [
    git
    just
    nixpkgs-fmt
    nix-linter
    manix
    nix-tree
  ];

  shellHook = ''
    echo
    echo -e "Nix Shell for NixOS development."
    echo
  '';
}
