{ nixpkgs, flake-utils, ... }@flakeInputs:
flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; };
    args = { inherit flakeInputs pkgs; };
  in { neovim = import ./neovim.nix args; })
