{ flakeInputs, pkgs, ... }:

path:
let
  lib = flakeInputs.self.lib.isolated // flakeInputs.self.lib.${pkgs.system};

  hostName = lib.fs.pathName path;
  dir = lib.dirIndex path;

  rootUsername = "root";
  homeModules = builtins.removeAttrs dir [ rootUsername ];

  homeEntry = name: module: {
    name = "${name}@${hostName}";
    value = lib.mkHomeConfig {
      inherit name hostName;
      modules = [ module ];
    };
  };

  homeEntries = builtins.attrValues (builtins.mapAttrs homeEntry homeModules);
  homeConfigurations = builtins.listToAttrs homeEntries;
  homeConfig = { inherit homeConfigurations; };

  mkHostConfig = opts:
    if pkgs.stdenv.isLinux then {
      nixosConfigurations.${hostName} = lib.mkNixosConfig opts;
    } else
      "";

  hostModule = dir.${rootUsername};
  hostConfig = if hostModule != null then
    mkHostConfig {
      name = hostName;
      modules = [ hostModule ];
      homeModules = homeModules;
    }
  else
    { };

in homeConfig // hostConfig
