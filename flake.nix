{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixColors = {
      url = "github:Misterio77/nix-colors/4.0.0";
      # inputs.nixpkgs-lib.follows = "nixpkgs.lib";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "homeManager";
    };

    nixVscodeExtensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, homeManager, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.system = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./system ];
    };

    homeConfigurations = {
      desktop = homeManager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = inputs // {
          vscodeExtensions = inputs.nixVscodeExtensions.extensions.${system};
        };
        modules = [
          ./home/desktop
          ./home/apps/gui
          ./home/apps/cli
        ];
      };
    };
  };
}
