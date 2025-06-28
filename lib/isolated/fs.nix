rec {
  pathExtSegments = path:
    builtins.filter
    (seg: builtins.isString seg && builtins.stringLength seg > 0)
    (builtins.split "[.]" (builtins.baseNameOf path));

  pathName = path: builtins.head (pathExtSegments path);

  pathExt = path:
    builtins.concatStringsSep "." (builtins.tail (pathExtSegments path));

  pathIsNix = path:
    (pathExt path) == "nix" && ((builtins.baseNameOf path) != "default.nix");

  dirIsNix = path: builtins.pathExists (path + "/default.nix");

  subDirs = parent:
    builtins.attrNames (builtins.readDir
      (builtins.filterSource (path: type: type == "directory") parent));

  filesWithExt = ext: dir:
    let
      sourceFilter = path: type:
        let
          len = builtins.stringLength path;
          extLen = builtins.stringLength ext;
          tail = builtins.substring (len - extLen) len path;
        in type == "regular" && tail == ext;

      source = builtins.filterSource sourceFilter dir;
      paths = builtins.attrNames (builtins.readDir source);
    in if builtins.pathExists dir then paths else [ ];
}
