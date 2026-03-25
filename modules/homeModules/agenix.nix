{ inputs, self, ... }: {
  flake.homeModules.agenix = { lib, config, ... }:
    let cfg = config.modules.agenix;
    in {
      options.modules.agenix = {
        enable = lib.mkEnableOption "agenix";
        host = lib.mkOption { types = lib.types.str; };
      };

      imports = [ inputs.agenix.homeManagerModules.default ];

      config = lib.mkIf cfg.enable {
        age.secrets = self.lib.secrets.makeSecretOptions
          self.secrets."${cfg.host}"."${config.home.username}";
      };
    };
}

