flakeInputs:
builtins.listToAttrs ((builtins.map (path: {
  name = flakeInputs.self.lib.path.name path;
  value = import path flakeInputs;
}) (flakeInputs.self.lib.dirIndex ./.)))
