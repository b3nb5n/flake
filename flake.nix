{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgsUnstable.url = "nixpkgs/nixos-unstable";

    homeManager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/v0.32.0";
    nix-colors.url = "github:Misterio77/nix-colors/4.0.0";
  };

  outputs = { nixpkgs, nixpkgsUnstable, homeManager, ... }@inputs:
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
          pkgsUnstable = nixpkgsUnstable.legacyPackages.${system};
        };
        modules = [ ./home/desktop ];
      };
    };
  };
}
