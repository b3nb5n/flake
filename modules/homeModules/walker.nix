{ inputs, ... }: {
  flake.homeModules.walker = { lib, config, ... }:
    let cfg = config.modules.walker;
    in {
      imports = [ inputs.walker.homeManagerModules.default ];

      options.modules.walker = { enable = lib.mkEnableOption "walker"; };

      config = lib.mkIf cfg.enable {
        programs.walker = {
          enable = cfg.enable;
          runAsService = true;
        };
      };
    };
}
