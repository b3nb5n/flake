flakeInputs:
flakeInputs.self.lib.mergeRec (builtins.map (path: import path flakeInputs)
  (builtins.attrValues (flakeInputs.self.lib.fs.dirIndex ./.)))
