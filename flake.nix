{
  inputs = rec {
    nixpkgs-stable.url = "nixpkgs/release-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs = nixpkgs-stable;

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    rgit = {
      url = "github:w4/rgit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    lib = import ./lib inputs;
    overlays = import ./overlays inputs;
    secrets = import ./secrets inputs;
    dotfiles = import ./dotfiles inputs;
    packages = import ./packages inputs;
    apps = import ./apps inputs;

    nixosModules = import ./modules/nixos inputs;
    homeModules = import ./modules/home inputs;

    inherit (import ./configs inputs)
      nixosConfigurations darwinConfigurations homeConfigurations;
  };
}
