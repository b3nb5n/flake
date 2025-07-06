{ hostName, pkgs, lib, config, ... }:
let cfg = config.modules.ssh;
in {
  options.modules.ssh = {
    enable = lib.mkEnableOption "ssh";

    matchFlakeHosts = lib.mkOption {
      type = lib.types.attrsOf
        (lib.types.submodule 
          ({ name, ... }: {
            options = {
              name = lib.mkOption {
                type = lib.types.str;
                default = name;
              };

              port = lib.mkOption {
                type = lib.types.port;
              };
            };
          }));
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      hashKnownHosts = true;
      matchBlocks = 
        let 
          flakeHostEntry = hostCfg: {
            inherit (hostCfg) name;
            value = {
              inherit (hostCfg) port;
              hostname = pkgs.self.lib.ageDecryptUnsafe
                { host = hostName; user = config.home.username; }
                { host = hostCfg.name; user = "root"; name = "public-ip"; };
            };
          };

          flakeHostConfigs = builtins.attrValues cfg.matchFlakeHosts;
          entries = builtins.map flakeHostEntry flakeHostConfigs;
        in builtins.listToAttrs entries;
    };
  };
}
