{
  inputs = {
    nixpkgs-stable.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };
  
  outputs = {
    nixpkgs-stable,
    nixpkgs-unstable,
    nur,
    nixos-hardware,
    home-manager,
    ...
  }: let
    inherit (nixpkgs-stable) lib;
    modules = import ./modules { inherit lib; };
    usrLib = import ./lib { inherit lib; };

    mkSystem = args: let
      pkgsArgs = {
        system = args.arch-os;
        config = {
          allowUnfree = true;
          allowUnfreePredicate =  _: true;
        };
      };

      nixpkgsStable = import nixpkgs-stable pkgsArgs;
      nixpkgsUnstable = import nixpkgs-unstable pkgsArgs;
      nurpkgs = import nur { pkgs = nixpkgsStable; nurpkgs = nixpkgsStable; };

      specialArgs = {
        inherit usrLib nixos-hardware;
        registries = { inherit nixpkgsStable nixpkgsUnstable nurpkgs; };
      };

      sharedModules = args.sharedModules ++ [
        { custom.system = { inherit (args) name arch-os; }; }
      ];
    in {
      nixosConfigurations.${args.name} = lib.nixosSystem {
        pkgs = nixpkgsStable;
        system = args.arch-os;
        inherit specialArgs;
        modules = args.modules ++ sharedModules ++ [
          modules.nixos.options
        ];
      };

      homeConfigurations = lib.attrsets.mapAttrs'
        (name: user: {
          name = "${name}@${args.name}";
          value = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgsStable;
            extraSpecialArgs = specialArgs // { user = user // { inherit name; }; };
            modules = user.modules ++ sharedModules ++ [
              modules.hm.options
              { custom.user = { inherit name; }; }
            ];
          }; 
        })
        args.users;
    };
  in usrLib.mergeRec [
    (mkSystem {
      name = "bnixdsk";
      arch-os = "x86_64-linux";
      modules = [ ./system/bnixdsk ];
      sharedModules = [
        modules.shared.system.bnixdsk
        modules.shared.theme.basic
      ];
      users = {
        ben = {
          modules = [
            modules.hm.user.ben
            ./home/environments/hyprland
            ./home/features
            ./home/local
          ];
        };
      };
    })
    (mkSystem {
      name = "aptnixsrv";
      arch-os = "x86_64-linux";
      modules = [ ./system/aptnixsrv ];
      sharedModules = [
        modules.shared.system.aptnixsrv
        modules.shared.theme.basic
      ];
      users = {
        ben = {
          modules = [
            modules.hm.user.ben
            ./home/environments/hyprland
            ./home/features
            ./home/local
          ];
        };
      };
    })
  ];
}
