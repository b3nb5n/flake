{ pkgs, const, utils, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      general.live_config_reload = false;
      window = {
        padding = { x = 12; y = 6; };
        decorations = "None";
      };
      scrolling = {
        history = 10000;
        multiplier = 2;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        blink_timeout = 0;
      };
      font.normal.family = const.theme.fonts.mono;
      colors = with const.theme.colors // utils.theme; rec {
        primary = {
          foreground = "#${hex base05}";
          background = "#${hex base00}";
          dim_foreground = "#${hex base04}";
          dim_background = "#${hex base01}";
          bright_foreground = "#${hex base06}";
        };
        normal = {
          black = "#${hex base00}";
          red = "#${hex base08}";
          green = "#${hex base0B}";
          yellow = "#${hex base0A}";
          blue = "#${hex base0D}";
          magenta = "#${hex base0E}";
          cyan = "#${hex base0C}";
          white = "#${hex base05}";
        };
        vi_mode_cursor = cursor; 
        cursor = {
          text = "#${hex base00}";
          cursor = "#${hex base05}";
        };
        search = {
          matches = {
            foreground = "#FF0000";
            background = "#000000";
          };
          focused_match = {
            foreground = "#00FF00";
            background = "#000000";
          };
        };
        hints = {
          start = {
            foreground = "#FF0000";
            background = "#000000";
          };
          end = {
            foreground = "#00FF00";
            background = "#000000";
          };
        };
        line_indicator = {
          foreground = "#FF0000";
          background = "#000000";
        };
        footer_bar = {
          foreground = "#FF0000";
          background = "#000000";
        };
        selection = {
          foreground = "#FF0000";
          background = "#000000";
        };
      };
    };
  };
}