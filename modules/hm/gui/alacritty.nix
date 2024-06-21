{ pkgs, lib, ... }: {
  home.sessionVariables.TERM = "alacritty";
  home.packages = with pkgs; [ fira-code-nerdfont ];

  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        (builtins.fetchurl {
          url =
            "https://github.com/folke/tokyonight.nvim/raw/v3.0.1/extras/alacritty/tokyonight_night.toml";
          sha256 = "mSj15JL+zBP6VNqbPgW5reHYPViwSzczQMxpyO/rQj4=";
        })
      ];
      window = {
        padding = {
          x = 6;
          y = 0;
        };
        decorations = lib.mkIf (!pkgs.stdenv.isDarwin) "None";
        dynamic_padding = true;
      };
      scrolling = {
        history = 10000;
        multiplier = 2;
      };
      cursor.blink_timeout = 0;
      font.normal.family = "FiraCode Nerd Font Mono";
    };
  };
}
