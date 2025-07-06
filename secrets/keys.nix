let
  lib = import ../lib/isolated;

  keyEntry = dir: name: {
    name = lib.fs.pathName name;
    value = builtins.readFile /${dir}/${name};
  };

  userEntry = host: name: {
    inherit name;
    value = let
      keysDir = ./${host}/${name}/keys;
      keyFiles = lib.fs.filesWithExt ".pub" keysDir;
      keyEntries = builtins.map (keyEntry keysDir) keyFiles;
      keys = builtins.listToAttrs keyEntries;

      explicitKeys = [ "unsafe" ];
      defaultKeys = builtins.attrValues
        (builtins.removeAttrs keys explicitKeys);

    in keys // { all = defaultKeys; };
  };

  hostEntry = name: {
    inherit name;
    value = let
      userDirs = lib.fs.subDirs ./${name};
      userEntries = builtins.map (userEntry name) userDirs;
    in builtins.listToAttrs userEntries;
  };

  hostNames = lib.fs.subDirs ./.;
  hostEntries = builtins.map hostEntry hostNames;
in builtins.listToAttrs hostEntries
