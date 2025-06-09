flakeInputs:
flakeInputs.self.lib.isolated.mergeRec
  (builtins.map
    (path: import path flakeInputs)
    (builtins.attrValues (flakeInputs.self.lib.isolated.dirIndex ./.)))
