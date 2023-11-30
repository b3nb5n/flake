{
  inputs = {
    nixpkgs-stable.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };
  
  outputs = {
    nixpkgs-stable,
    nixpkgs-unstable,
    nur,
    home-manager,
    ...
  }: let
    importRegistries = system: let
      pkgsArgs = {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate =  _: true;
        };
      };
    in rec {
      nixpkgsStable = import nixpkgs-stable pkgsArgs;
      nixpkgsUnstable = import nixpkgs-unstable pkgsArgs;
      nurpkgs = import nur { pkgs = nixpkgsStable; nurpkgs = nixpkgsStable; };
    };

    inherit (nixpkgs-stable) lib;
    usrLib = import ./lib { inherit lib; };
    const = import ./const { inherit lib usrLib; };
    modules = import ./modules {};

    specialArgs = { inherit usrLib; };

    mkSystem = { const, modules }: let
      registries = importRegistries const.system.arch-os;
    in {
      ${const.system.name} = lib.nixosSystem {
        pkgs = registries.nixpkgsStable;
        system = const.system.arch-os;
        specialArgs = specialArgs // { inherit registries const; };
        modules = modules ++ [ ./modules/options ];
      };
    };

    mkUser = { const, modules }: let
      registries = importRegistries const.system.arch-os;
    in {
      "${const.user.name}@${const.system.name}" = home-manager.lib.homeManagerConfiguration {
        pkgs = registries.nixpkgsStable;
        extraSpecialArgs = specialArgs // { inherit registries const; };
        modules = modules ++ [ ./modules/options ];
      };
    };
  in {
    nixosConfigurations = 
      mkSystem {
        const = {
          user = const.users.ben;
          system = const.systems.bnixdsk;
          hardware.monitors = const.hardware.monitors.desktop;
        };
        modules = [ 
          ./system/desktop

          ./modules/themes/basic.nix
        ];
      };

    homeConfigurations =
      mkUser {
        const = {
          user = const.users.ben;
          system = const.systems.bnixdsk;
          hardware.monitors = const.hardware.monitors.desktop;
        };
        modules = [
          ./home/environments/hyprland
          ./home/features
          ./home/local

          ./modules/themes/basic.nix
        ];
      };
  };
}
