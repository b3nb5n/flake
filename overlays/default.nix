flakeInputs:
builtins.mapAttrs (name: path: import path flakeInputs)
(flakeInputs.self.lib.dirIndex ./.)
