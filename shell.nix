{ pkgs ? import <nixpkgs> { }, ... }:

with pkgs;

mkShell {

  buildInputs = [
    git
    just
    nixpkgs-fmt
    manix
    nix-tree
    tokei
    # doas must be installed at system level
  ];

  shellHook = ''
    echo
    echo -e "Nix Shell for NixOS development."
    echo
  '';
}
