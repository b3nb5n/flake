{ inputs, self, ... }: {
  flake.nixosModules.agenix = { lib, config, ... }:
    let cfg = config.modules.agenix;
    in {
      options.modules.agenix.enable = lib.mkEnableOption "agenix";

      imports = [ inputs.agenix.nixosModules.default ];

      config = lib.mkIf cfg.enable {
        age.secrets = self.lib.secrets.makeSecretOptions
          self.secrets."${config.networking.hostName}".root;
      };
    };
}

