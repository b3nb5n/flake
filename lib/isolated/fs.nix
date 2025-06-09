rec {
  pathExtSegments = path:
    builtins.filter
      (seg: builtins.isString seg && builtins.stringLength seg > 0)
      (builtins.split "[.]" (builtins.baseNameOf path));

  pathName = path: builtins.head (pathExtSegments path);

  pathExt = path:
    builtins.concatStringsSep "." (builtins.tail (pathExtSegments path));

  pathIsNix = path:
    (pathExt path) == "nix"
    && ((builtins.baseNameOf path) != "default.nix");

  dirIsNix = path: builtins.pathExists (path + "/default.nix");

  subDirs = parent: builtins.attrNames
    (builtins.readDir
      (builtins.filterSource
        (path: type: type == "directory")
        parent));
}
