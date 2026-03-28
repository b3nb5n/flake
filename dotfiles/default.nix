{ self, lib, ... }: {
  options.flake.dotfiles = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
  };

  config.flake.dotfiles = let
    dotfilesRoot = "${self.outPath}/dotfiles";
    dirFilter = (_path: type: type == "directory");
    dotfilesDir = builtins.filterSource dirFilter dotfilesRoot;
    dirNames = (builtins.attrNames (builtins.readDir dotfilesDir));

    pathEntries = builtins.map (name: {
      inherit name;
      value = "${dotfilesRoot}/${name}";
    });
  in builtins.listToAttrs (pathEntries dirNames);
}
