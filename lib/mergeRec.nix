flakeInputs: values:
let
  merge = a: b:
    if builtins.isAttrs a && builtins.isAttrs b then
      a // (builtins.mapAttrs (k: v:
        if builtins.hasAttr k a then merge (builtins.getAttr k a) v else v) b)
    else if builtins.isList a && builtins.isList b then
      a ++ b
    else
      b;
in builtins.foldl' merge { } values
