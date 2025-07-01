{ flakeInputs, lib, config, ... }:
let cfg = config.modules.rgit;
in {
  options.modules.rgit = {
    enable = lib.mkEnableOption "rgit";
    port = lib.mkOption {
      type = lib.types.port;
      default = 3333;
    };
  };

  # TODO: WHYYYY does using `pkgs.system` here cause infinite recursion?!?!?!
  imports = [ flakeInputs.rgit.nixosModules."x86_64-linux".default ];

  config = lib.mkIf cfg.enable {
    services = {
      rgit = {
        enable = true;
        bindAddress = "[::]:${builtins.toString cfg.port}";
        dbStorePath = "/tmp/rgit.db";
        repositoryStorePath = "/var/lib/git";
      };

      nginx.virtualHosts.git = {
        serverName = "git.${config.networking.domain}";
        locations."/".proxyPass =
          "http://127.0.0.1:${builtins.toString cfg.port}";
      };
    };

    systemd.tmpfiles.rules = [
      "d ${config.services.rgit.repositoryStorePath} 0770 ${config.users.users.rgit.name} ${config.users.groups.rgit.name}"
    ];
  };
}
