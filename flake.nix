{

 description = "NixOS configuration";

 inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { home-manager, nixpkgs, ... }: {
    nixosConfigurations = {
      auto = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./os/conf.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ralvarez = import ./home/conf.nix;
          }
        ];
      };
    };
  };


}
