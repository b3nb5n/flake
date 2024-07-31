flakeInputs:
builtins.mapAttrs (path: import path flakeInputs)
(flakeInputs.self.lib.dirIndex ./.)
