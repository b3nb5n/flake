flakeInputs:
let fs = import ./fs.nix flakeInputs;
in builtins.mapAttrs (name: path: (import path flakeInputs)) (fs.dirIndex ./.)
