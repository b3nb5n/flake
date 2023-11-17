{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nur, homeManager, ... }@inputs:
  let
    utils = import ./utils { lib = nixpkgs.lib; };
    const = import ./const { inherit utils; };
    system = const.system.system;

    pkgs = nixpkgs.legacyPackages.${system};
    nurpkgs = import nur { nurpkgs = pkgs; inherit pkgs; };

    specialArgs = inputs // { inherit nurpkgs const utils; };
  in {
    nixosConfigurations.system = nixpkgs.lib.nixosSystem {
      inherit system specialArgs;
      modules = [ ./system ];
    };

    homeConfigurations = {
      desktop = homeManager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = specialArgs;
        modules = [
          ./home/environments/desktop
          ./home/features
          ./home/local
        ];
      };
    };
  };
}
