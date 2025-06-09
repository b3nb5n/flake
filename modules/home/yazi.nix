{ pkgs, lib, config, ... }:
let cfg = config.modules.yazi;
in {
  options.modules.yazi = {
    enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      settings = {
        mgr = {
          show_hidden = true;
        };
      };
    };

    # xdg.configFile."yazi/theme.toml".source =
    #   "${pkgs.self.tokyonight}/extras/yazi/tokyonight_night.toml";
  };
}
