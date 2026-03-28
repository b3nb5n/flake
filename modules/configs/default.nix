{ inputs, self, lib, ... }: {
  imports = [
    inputs.config-parts.flakeModules.nixos

    inputs.home-manager.flakeModules.default
    inputs.config-parts.flakeModules.home-manager
  ];

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

  config.flake = {
    nixosConfigurationArgs' = [{
      modules = [
        ({ outputName, ... }: {
          networking.hostName = outputName;
          nixpkgs.config.allowUnfree = true;
        })
      ];
    }];

    homeConfigurationArgs' = [
      ({ outputUser, outputHost, ... }: {
        pkgs = lib.mkIf
          (outputHost != null && self.nixosConfigurations ? ${outputHost})
          (lib.mkDefault self.nixosConfigurations.${outputHost}.pkgs);

        modules = [{ home.username = outputUser; }];
      })
    ];
  };
}
