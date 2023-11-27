{
  inputs = {
    # nixpkgs-stable.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  
  outputs = {
    # nixpkgs-stable,
    nixpkgs-unstable,
    nur,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";

    # stablePkgs = nixpkgs-stable.legacyPackages.${system};
    pkgs = nixpkgs-unstable.legacyPackages.${system};
    nurPkgs = import nur { nurpkgs = pkgs; inherit pkgs; };

    usrLib = import ./lib { lib = nixpkgs-unstable.lib; };
    const = import ./const { inherit pkgs usrLib; };

    specialArgs = { inherit nurPkgs system usrLib const; };
    extraSpecialArgs = specialArgs;
  in {
    nixosConfigurations.system = nixpkgs-unstable.lib.nixosSystem {
      inherit system specialArgs;
      modules = [ ./system ];
    };

    homeConfigurations = {
      desktop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./home/environments/desktop
          ./home/features
          ./home/local
        ];
      };
    };
  };
}
