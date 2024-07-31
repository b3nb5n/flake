flakeInputs:
builtins.listToAttrs ((builtins.map (path: {
  name = flakeInputs.self.lib.path.name path;
  value = path;
}) (flakeInputs.self.lib.dirIndex ./.)))
