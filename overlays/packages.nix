flakeInputs: final: prev:
builtins.mapAttrs (k: v: builtins.getAttr final.system v)
flakeInputs.self.packages
