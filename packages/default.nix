{ self, nixpkgs, ... }@flakeInputs:
let dir = self.lib.isolated.dirIndex ./.;
in builtins.listToAttrs (builtins.map
  (system: {
    name = system;
    value =
      let 
          pkgs = import nixpkgs { 
            inherit system; 
            overlays = builtins.attrValues self.overlays;
          };
      in builtins.mapAttrs
        (name: path: pkgs.callPackage path { inherit flakeInputs; })
        dir;
  })
  nixpkgs.lib.systems.flakeExposed)
