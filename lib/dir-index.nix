flakeInputs: dirPath:
let
  pathIsNix = path:
    flakeInputs.self.lib.path.ext path == "nix"
    && (builtins.baseNameOf path != "default.nix");

  dirIsNix = path: builtins.pathExists (path + "/default.nix");

  dir = builtins.readDir (builtins.filterSource (path: type:
    (type == "regular" && pathIsNix path)
    || (type == "directory" && dirIsNix path)) dirPath);

  srcs = builtins.listToAttrs (builtins.map (path: {
    name = flakeInputs.self.lib.path.name path;
    value = dirPath + "/${path}";
  }) (builtins.attrNames dir));
in srcs
