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
      enableDefaultConfig = false;

      matchBlocks = let 
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
        flakeHosts = builtins.listToAttrs (builtins.map flakeHostEntry flakeHostConfigs);
      in flakeHosts // {
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };
      };
    };
  };
}
