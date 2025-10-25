{ flakeInputs, pkgs, lib, config, ... }:
let cfg = config.modules.yazi;
in {
  options.modules.yazi = {
    enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ yazi ];

    xdg.configFile.yazi.source =
      "${flakeInputs.self.dotfiles.yazi}/.config/yazi";
  };
}
