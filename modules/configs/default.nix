{ inputs, self, lib, ... }: {
  imports = [ inputs.home-manager.flakeModules.default ];

  options.flake = {
    keys = lib.mkOption {
      type = self.lib.secrets.keysType;
      default = { };
    };

    secrets = lib.mkOption {
      type = self.lib.secrets.secretsType;
      default = { };
    };
  };
}
