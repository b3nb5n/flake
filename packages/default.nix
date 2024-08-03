{ nixpkgs, self, ... }@flakeInputs:
let dir = self.lib.dirIndex ./.;
in builtins.listToAttrs (builtins.map (system: {
  name = system;
  value = builtins.mapAttrs (name: path:
    import path {
      inherit flakeInputs;
      pkgs = import nixpkgs { inherit system; };
    }) dir;
}) nixpkgs.lib.systems.flakeExposed)
