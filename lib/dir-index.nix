flakeInputs: dirPath:
let
  pathIsNix = path:
    flakeInputs.self.lib.path.ext path == "nix"
    && (builtins.baseNameOf path != "default.nix");

  dirIsNix = path: builtins.pathExists "${path}/default.nix";

  dir = builtins.filterSource (path: type:
    (type == "regular" && pathIsNix path)
    || (type == "directory" && dirIsNix path)) dirPath;

in builtins.map (src: dirPath + "/${src}")
(builtins.attrNames (builtins.readDir dir))
