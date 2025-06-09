{ pkgs, lib, config, ... }:
let cfg = config.modules.spotify;
in {
  options.modules.spotify = {
    enable = lib.mkEnableOption "spotify";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ spotify ];

    xdg.autostart.desktopItems = [
      (pkgs.makeDesktopItem {
        name = "spotify";
        desktopName = "Spotify";
        type = "Application";
        exec = "${pkgs.spotify}/bin/spotify";
      })
    ];

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
