{ self, nixpkgs, ... } @ flakeInputs:

let
  dirIndex = import ../isolated/dirIndex.nix;
  dir = dirIndex ./.;

  mkSysLibEntry = system: {
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
  };
in

builtins.listToAttrs
  (builtins.map
    mkSysLibEntry
    nixpkgs.lib.systems.flakeExposed)
