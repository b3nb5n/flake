let
  flake = builtins.getFlake "path:${builtins.toString ./.}";
  secretsOutput = flake.lib.secrets.secretsType.merge [ "secrets" ] [{
    file = "${flake.outPath}/flake.nix";
    value = flake.secrets;
  }];

  flat = list: builtins.foldl' (a: b: a ++ b) [ ] list;

  secretModule = secretOutput:
    let
      srcFile = builtins.unsafeGetAttrPos "file" secretOutput;
      file = if srcFile != null then srcFile else secretOutput.file;

      publicKeys = secretOutput.publicKeys or [ ];
      armor = secretOutput.armor or false;
      secretValue = { inherit publicKeys armor; };
      secretPath = flake.lib.path.relative flake.outPath secretOutput.file;
      value = { "${secretPath}" = secretValue; };
    in { inherit file value; };

  userSecretModules = userOutput:
    let
      secretOutputs = builtins.attrValues userOutput;
      entries = builtins.map secretModule secretOutputs;
    in entries;

  systemSecretModules = systemOutput:
    let
      userOutputs = builtins.attrValues systemOutput;
      entries = builtins.map userSecretModules userOutputs;
    in flat entries;

  secretModules = let
    systemOutputs = builtins.attrValues secretsOutput;
    entries = builtins.map systemSecretModules systemOutputs;
  in flat entries;
in flake.lib.secrets.secretsFileType.merge [ ] secretModules
