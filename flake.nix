{
  inputs = {
    nixpkgs-stable.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, nur, home-manager, flake-utils
    , rust-overlay, ... }@flakeInputs:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgsArgs = {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
            nvidia.accptLicense = true;
          };
          # overlays = (import ./overlays inputs)
          #   ++ [ (import rust-overlay) devshell.overlays.default ];
        };

        nixpkgsStable = import nixpkgs-stable pkgsArgs;
        nixpkgsUnstable = import nixpkgs-unstable pkgsArgs;
        nurpkgs = import nur {
          pkgs = nixpkgsUnstable;
          nurpkgs = nixpkgsUnstable;
        };

        args = {
          inherit flakeInputs system;
          pkgs = nixpkgsUnstable;
          usrLib = import ./lib args;
          repos = {
            inherit nixpkgsStable nixpkgsUnstable nurpkgs;
            usrDrv = import ./drv args;
          };
        };
      in (import ./outputs args)));
}
