{ lib, ... }: {
  options.flake.dotfiles = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
    default = { };
  };

  config.flake.dotfiles = let
    dotfilesDir = builtins.filterSource (_path: type: type == "directory") ./.;
    dirPaths = (builtins.attrNames (builtins.readDir dotfilesDir));
    pathEntries = builtins.map (path: {
      name = "${path}";
      value = ./${path};
    });
  in builtins.listToAttrs (pathEntries dirPaths);
}
