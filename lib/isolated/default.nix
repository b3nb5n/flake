let
  dirIndex = import ./dirIndex.nix;
in

builtins.mapAttrs
  (name: path: (import path))
  (dirIndex ./.)
