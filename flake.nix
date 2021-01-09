{

  description = "NixOS configuration using Flakes and Home-Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";
    in
    {

      nixosConfigurations.auto = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = system;
        modules = [
          ./hosts/auto
          ./users/ralvarez
          ./hardware/x1c6
          # external
          home-manager.nixosModules.home-manager
        ];
      };

      devShell."${system}" = import ./shell.nix { inherit pkgs; };

    };

}
