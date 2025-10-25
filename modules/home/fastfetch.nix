{ flakeInputs, pkgs, lib, config, ... }:
let cfg = config.modules.fastfetch;
in {
  options.modules.fastfetch = {
    enable = lib.mkEnableOption "fastfetch";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ fastfetch ];

    xdg.configFile.fastfetch.source =
      "${flakeInputs.self.dotfiles.fastfetch}/.config/fastfetch";
  };
}
