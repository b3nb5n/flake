{ self, lib, ... }: {
  flake.lib.secrets = {
    keysType = let
      inherit (lib.types) lazyAttrsOf listOf either uniq str;

      keyList = either str (listOf (uniq str));
      keyAttrs = lazyAttrsOf keyList;
      userAttrs = lazyAttrsOf keyAttrs;
      systemAttrs = lazyAttrsOf userAttrs;
    in systemAttrs;

    secretsType = let
      inherit (lib.types) submodule lazyAttrsOf listOf uniq path str bool;

      fileOption = lib.mkOption {
        type = path;
        description = "Path to the age encrypted secret file";
      };

      publicKeysOption = lib.mkOption {
        type = listOf (uniq str);
        default = [ ];
        description =
          "List of public keys who's corresponding private keys can be used to decrypt the secret file";
      };

      armorOption = lib.mkOption {
        type = bool;
        default = false;
        description =
          "Whether the secret file should be formatted in the Base64 PEM format";
      };

      secretModule = submodule {
        options = {
          file = fileOption;
          publicKeys = publicKeysOption;
          armor = armorOption;
        };
      };

      secretAttrs = lazyAttrsOf secretModule;
      userAttrs = lazyAttrsOf secretAttrs;
      systemAttrs = lazyAttrsOf userAttrs;
    in systemAttrs;

    secretsFileType = let
      inherit (lib.types) submodule attrsOf listOf str bool;

      publicKeysOption = lib.mkOption {
        type = listOf str;
        default = [ ];
        description =
          "List of public keys who's corresponding private keys can be used to decrypt the secret file";
      };

      armorOption = lib.mkOption {
        type = bool;
        default = false;
        description =
          "Whether the secret file should be formatted in the Base64 PEM format";
      };

      secretType = submodule {
        options = {
          publicKeys = publicKeysOption;
          armor = armorOption;
        };
      };

      secretAttrs = attrsOf secretType;
    in secretAttrs;

    importSecretsDir = _args:
      let
        inherit (lib.types) submodule attrsOf listOf path str bool;

        secretType = { config, ... }:
          (submodule ({ name, ... }: {
            options = {
              file = lib.mkOption {
                type = path;
                default = /${config.path}/${name}.age;
              };

              publicKeys = lib.mkOption {
                type = listOf str;
                default = config.defaultPublicKeys;
              };

              extraPublicKeys = lib.mkOption {
                type = listOf str;
                default = [ ];
              };

              armor = lib.mkOption {
                type = bool;
                default = config.defaultArmor;
              };
            };
          }));

        argsType = submodule ({ config, ... }@argsModule: {
          options = {
            path = lib.mkOption { type = path; };

            secrets = lib.mkOption {
              type = attrsOf (secretType argsModule);
              default = { };
            };

            defaultPublicKeys = lib.mkOption {
              type = listOf str;
              default = [ ];
            };

            defaultArmor = lib.mkOption {
              type = bool;
              default = false;
            };
          };

          config = {
            secrets = let
              ageFilter = path: type:
                let
                  isFile = type != "directory";
                  isAge = (self.lib.path.ext path) == "age";
                in isFile && isAge;

              secretEntry = fileName: {
                name = self.lib.path.name fileName;
                value = { file = /${config.path}/${fileName}; };
              };

              ageSource = builtins.filterSource ageFilter config.path;
              secretFileNames = builtins.attrNames (builtins.readDir ageSource);
              secretEntries = builtins.map secretEntry secretFileNames;
            in builtins.listToAttrs secretEntries;
          };
        });

        argsPos = builtins.unsafeGetAttrPos "path" _args;
        argsModule = {
          inherit (argsPos) file;
          value = _args;
        };
        args = argsType.merge [ ] [ argsModule ];

        secretOutput = _name: secretArg: {
          inherit (secretArg) file armor;
          publicKeys = secretArg.publicKeys ++ secretArg.extraPublicKeys;
        };
      in builtins.mapAttrs secretOutput args.secrets;

    makeSecretOptions = secretsOutput:
      let secretOption = _name: secretOutput: { inherit (secretOutput) file; };
      in builtins.mapAttrs secretOption secretsOutput;
  };
}
