{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/release-23.11";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, nur, home-manager, ... }: let
    usrLib = import ./lib { lib = nixpkgs.lib; };
    const = import ./const { inherit usrLib; };

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    stablePkgs = nixpkgs-stable.legacyPackages.${system};

    nurPkgs = import nur { nurpkgs = pkgs; inherit pkgs; };

    specialArgs = { inherit stablePkgs nurPkgs system const usrLib; };
  in {
    nixosConfigurations.system = nixpkgs-stable.lib.nixosSystem {
      inherit system specialArgs;
      modules = [ ./system ];
    };

    homeConfigurations = {
      desktop = home-manager.lib.homeManagerConfiguration {
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
