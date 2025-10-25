{ pkgs, lib, config, ... }:
let cfg = config.modules.spotify;
in {
  options.modules.spotify = {
    enable = lib.mkEnableOption "spotify";
    
    package = lib.mkPackageOption pkgs [ "spotify" ] {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.autostart.entries = [ "${cfg.package}/share/applications/spotify.desktop" ];

    programs.spotify-player = {
      enable = true;
      settings = {
        theme = "tokyonight";
        border_type = "Rounded";
        enable_notify = false;
      };
    };

    # xdg.configFile."spotify-player/theme.toml".source =
    #   "${pkgs.self.tokyonight}/extras/spotify_player/tokyonight_night.toml";
  };
}
