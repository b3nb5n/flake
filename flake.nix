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
  };
  
  outputs = inputs: let
    usrLib = import ./lib inputs;
  in usrLib.mergeRec [
    (import ./systems/bnixdsk inputs)
  ];
}
