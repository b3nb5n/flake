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
    system = "x86_64-linux";
    pkgsArgs = {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate =  _: true;
      };
    };

    pkgs = import nixpkgs-stable pkgsArgs;
    unstablePkgs = import nixpkgs-unstable pkgsArgs;
    nurPkgs = import nur { nurpkgs = pkgs; inherit pkgs; };

    usrLib = import ./lib { lib = nixpkgs-stable.lib; };
    const = import ./const { inherit pkgs usrLib; };

    specialArgs = { inherit unstablePkgs nurPkgs system usrLib const; };

    mkSystem = { name, modules }: {
      ${name} = nixpkgs-stable.lib.nixosSystem {
        inherit pkgs system specialArgs;
        modules = modules ++ [
          { networking.hostName = name; }
        ];
      };
    };

    mkUser = modules: home-manager.lib.homeManagerConfiguration {
      inherit pkgs modules;
      extraSpecialArgs = specialArgs;
    };
  in {
    nixosConfigurations = 
      mkSystem { name = "bnixdsk"; modules = [ ./system/desktop ]; };

    homeConfigurations = {
      ${const.user.name} = mkUser [
        ./home/environments/hyprland
        ./home/features
        ./home/local
      ];
    };
  };
}
