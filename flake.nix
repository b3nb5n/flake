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
  
  outputs = inputs: let
    usrLib = import ./lib inputs;
  in usrLib.mergeRec [
    (import ./systems/bnixdsk inputs)
  ];
}
