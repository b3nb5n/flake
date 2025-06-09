{
  inputs = rec {
    nixpkgs-stable.url = "nixpkgs/release-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs = nixpkgs-unstable;

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "nix-darwin";
        home-manager.follows = "home-manager";
      };
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    lib = import ./lib inputs;
    overlays = import ./overlays inputs;
    dotfiles = import ./dotfiles inputs;
    packages = import ./packages inputs;
    apps = import ./apps inputs;

    nixosModules = import ./modules/nixos inputs;
    homeModules = import ./modules/home inputs;

    inherit (import ./configs inputs)
      nixosConfigurations darwinConfigurations homeConfigurations;
  };
}

