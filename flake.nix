{
  inputs = {
    nixpkgs-stable.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, nur, home-manager, flake-utils
    , rust-overlay, ... }@inputs:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgsArgs = {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
            allowUnsupportedSystem = true;
          };
          overlays = [ (import rust-overlay) ];
        };

        nixpkgsStable = import nixpkgs-stable pkgsArgs;
        nixpkgsUnstable = import nixpkgs-unstable pkgsArgs;
        nurpkgs = import nur {
          pkgs = nixpkgsUnstable;
          nurpkgs = nixpkgsUnstable;
        };

        args = {
          flakeInputs = inputs;
          pkgs = nixpkgsUnstable;
          registries = { inherit nixpkgsStable nixpkgsUnstable nurpkgs; };
          usrLib = import ./lib args;
          usrDrv = import ./drv args;
        };
      in (import ./outputs args)));
}
