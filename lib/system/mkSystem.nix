{ flakeInputs, pkgs, ... }:

{ name, users }:

let
  lib = flakeInputs.self.lib.${pkgs.system};

  rootUsername = "root";
  regularUserNames = builtins.attrNames
    (builtins.removeAttrs users [ rootUsername ]);

  reqularUsersRootConfig = builtins.listToAttrs
    (builtins.map
      (userName: {
        name = userName;
        value.isNormalUser = true;
      })
      regularUserNames);

  rootConfig =
    if !(builtins.hasAttr rootUsername users) then null
    else
      lib.mkNixosConfig {
        inherit name;
        modules = users.${rootUsername} ++
          [{ users.users = reqularUsersRootConfig; }];
      };

  mkUserConfigEntry = userName: {
    name = "${userName}@${name}";
    value = lib.mkHomeConfig {
      name = userName;
      hostName = name;
      hostConfig = rootConfig;
      modules = users.${userName};
    };
  };

  rootConfigOutputs =
    if rootConfig == null then { }
    else { nixosConfigurations.${name} = rootConfig; };

  userConfigOutputs = {
    homeConfigurations =
      builtins.listToAttrs
        (builtins.map
          mkUserConfigEntry
          regularUserNames);
  };
in

rootConfigOutputs // userConfigOutputs
