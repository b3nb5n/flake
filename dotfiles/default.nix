flakeInputs:
builtins.listToAttrs
  (builtins.map
    (path: { name = path; value = ./${path}; })
    (builtins.attrNames (builtins.readDir ./.)))
