{ pkgs, usrLib, config, ... }: {
  home.sessionVariables.TERM = "alacritty";

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
      font.normal.family = config.custom.theme.font.mono.name;
      colors = with config.custom.theme.color // usrLib.color; rec {
        primary = {
          background = hex (builtins.elemAt bg 0);
          foreground = hex (builtins.elemAt fg 0);
          dim_foreground = (builtins.elemAt fg 2);
        };
        normal = {
          black = hex black.default;
          red = hex red.default;
          green = hex green.default;
          yellow = hex yellow.default;
          blue = hex blue.default;
          magenta = hex pink.default;
          cyan = hex cyan.default;
          white = hex white.default;
        };
        bright = {
          black = hex black.light;
          red = hex red.light;
          green = hex green.light;
          yellow = hex yellow.light;
          blue = hex blue.light;
          magenta = hex pink.light;
          cyan = hex cyan.light;
          white = hex white.light;
        };
        dim = {
          black = hex black.dark;
          red = hex red.dark;
          green = hex green.dark;
          yellow = hex yellow.dark;
          blue = hex blue.dark;
          magenta = hex pink.dark;
          cyan = hex cyan.dark;
          white = hex white.dark;
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