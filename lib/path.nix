flakeInputs: rec {
  extSegments = path:
    builtins.filter
    (seg: builtins.isString seg && builtins.stringLength seg > 0)
    (builtins.split "[.]" (builtins.baseNameOf path));

  name = path: builtins.head (extSegments path);

  ext = path: builtins.concatStringsSep "." (builtins.tail (extSegments path));
}
