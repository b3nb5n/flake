{ nixpkgs, self, ... }@flakeInputs:
let dir = self.lib.fs.dirIndex ./.;
in builtins.listToAttrs (builtins.map (system: {
  name = system;
  value = let pkgs = import nixpkgs { inherit system; };
  in builtins.mapAttrs
  (name: path: pkgs.callPackage path { inherit flakeInputs; }) dir;
}) nixpkgs.lib.systems.flakeExposed)
