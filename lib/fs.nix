flakeInputs: rec {
  extSegments = path:
    builtins.filter
    (seg: builtins.isString seg && builtins.stringLength seg > 0)
    (builtins.split "[.]" (builtins.baseNameOf path));

  fileName = path: builtins.head (extSegments path);

  fileExt = path:
    builtins.concatStringsSep "." (builtins.tail (extSegments path));

  dirIndex = dirPath:
    let
      pathIsNix = path:
        (fileExt path) == "nix"
        && ((builtins.baseNameOf path) != "default.nix");

      dirIsNix = path: builtins.pathExists (path + "/default.nix");

      dir = builtins.readDir (builtins.filterSource (path: type:
        (type == "regular" && pathIsNix path)
        || (type == "directory" && dirIsNix path)) dirPath);

      srcs = builtins.listToAttrs (builtins.map (path: {
        name = fileName path;
        value = dirPath + "/${path}";
      }) (builtins.attrNames dir));
    in srcs;
}
