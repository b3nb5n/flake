{ nixpkgs, flake-utils, self, ... }@flakeInputs:
flake-utils.lib.eachDefaultSystem (system:
  builtins.listToAttrs (builtins.map (path: {
    name = self.lib.path.name path;
    value = import path {
      inherit flakeInputs;
      pkgs = import nixpkgs { inherit system; };
    };
  }) (self.lib.dirIndex ./.)))
