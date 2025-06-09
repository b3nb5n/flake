dirPath:

let
  fsLib = import ./fs.nix;

  dir = builtins.readDir (builtins.filterSource
    (path: type:
      (type == "regular" && fsLib.pathIsNix path)
      || (type == "directory" && fsLib.dirIsNix path))
    dirPath);

  mkEntry = path: {
    name = fsLib.pathName path;
    value = dirPath + "/${path}";
  };
in

builtins.listToAttrs
  (builtins.map
    mkEntry
    (builtins.attrNames dir))
