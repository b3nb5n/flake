let
  lib = import ../lib/isolated;

  keys = import ./keys.nix;

  extraSecretRecipients = with keys; {
    vessel.ben.password = vessel.root.all;
    wyrm.ben.password = wyrm.root.all;
  };

  secret = host: user: file:
    let
      name = lib.fs.pathName file;
      path = ./${host}/${user}/${file};

      ownerRecipients = keys.${host}.${user}.all or [ ];
      extraRecipients = extraSecretRecipients.${host}.${user}.${name} or [ ];
      recipients = ownerRecipients ++ extraRecipients;
    in { inherit host user name path recipients; };

  userSecrets = host: user:
    let
      userDir = ./${host}/${user};
      secretFiles = lib.fs.filesWithExt ".age" userDir;
    in builtins.map (secret host user) secretFiles;

  hostSecrets = host:
    let
      userDirs = lib.fs.subDirs ./${host};
      userSecrets_ = builtins.map (userSecrets host) userDirs;
    in lib.lists.flatten userSecrets_;

  hostDirs = lib.fs.subDirs ./.;
  hostSecrets_ = builtins.map hostSecrets hostDirs;
in lib.lists.flatten hostSecrets_
