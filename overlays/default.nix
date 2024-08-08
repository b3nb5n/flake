flakeInputs:
builtins.mapAttrs (name: path: import path flakeInputs)
(flakeInputs.self.lib.fs.dirIndex ./.)
