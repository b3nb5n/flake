{ nixpkgs, flake-utils, self, ... }@flakeInputs:
flake-utils.lib.eachDefaultSystem (system:
  builtins.mapAttrs (path:
    import path {
      inherit flakeInputs;
      pkgs = import nixpkgs { inherit system; };
    }) (self.lib.dirIndex ./.))
