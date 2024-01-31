{
  inputs = {
    nixpkgs-stable.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, nur, home-manager, flake-utils
    , ... }@inputs:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgsArgs = {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };

        nixpkgsStable = import nixpkgs-stable pkgsArgs;
        nixpkgsUnstable = import nixpkgs-unstable pkgsArgs;
        nurpkgs = import nur {
          pkgs = nixpkgsUnstable;
          nurpkgs = nixpkgsUnstable;
        };
      in (import ./config {
        flakeInputs = inputs;
        pkgs = nixpkgsUnstable;
        registries = { inherit nixpkgsStable nixpkgsUnstable nurpkgs; };
        usrLib = (import ./lib { inherit (nixpkgs-unstable) lib; });
      })));
}
