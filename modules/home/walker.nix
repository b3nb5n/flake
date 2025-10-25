{ flakeInputs, lib, config, ... }:
let cfg = config.modules.walker;
in {
  imports = [ flakeInputs.walker.homeManagerModules.default ];

  options.modules.walker = {
    enable = lib.mkEnableOption "walker";
  };

  config = lib.mkIf cfg.enable {
    programs.walker = {
      enable = cfg.enable;
      runAsService = true;
    };
  };
}
