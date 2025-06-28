let
  lib = import ../lib/isolated;

  keyEntry = dir: name: {
    name = lib.fs.pathName name;
    value = builtins.readFile /${dir}/${name};
  };

  userEntry = host: name: {
    inherit name;
    value = let
      userDir = ./${host}/${name};
      keyFiles = lib.fs.filesWithExt ".pub" userDir;
      keyEntries = builtins.map (keyEntry userDir) keyFiles;

      entries = keyEntries ++ [{
        name = "all";
        value = builtins.map (builtins.getAttr "value") keyEntries;
      }];
    in builtins.listToAttrs entries;
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
