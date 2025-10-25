{ flakeInputs, pkgs, lib, config, ... }:
let cfg = config.modules.direnv;
in {
  options.modules.direnv = {
    enable = lib.mkEnableOption "direnv";
  };

  config = lib.mkIf cfg.enable {
    home.packages =  with pkgs; [ direnv ];

    xdg.configFile.direnv.source =
      "${flakeInputs.self.dotfiles.direnv}/.config/direnv";
  };
}
