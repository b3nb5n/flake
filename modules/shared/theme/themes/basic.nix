{ pkgs, usrLib, ... }: {
  custom.theme = {
    color = usrLib.mapRec (usrLib.color.parseHex)  rec {
      bg = [
        "#141418"
        "#1e1e25"
        "#2b313a"
        "#3a4250"
      ];
      fg = [
        "#F8FAFC"
        "#d8dbe0"
        "#adadb6"
        "#92929c"
      ];

      accent = purple;

      red = {
        dark = "#b12e42";
        default = "#D95468";
        light = "#f77689";
      };
      orange = {
        dark = "#e67c3f";
        default = "#FF9E64";
        light = "#ffbf9a";
      };
      yellow = {
        dark = "#e0b637";
        default = "#ebcc6e";
        light = "#fde7a4";
      };
      green = {
        dark = "#448f55";
        default = "#60c477";
        light = "#8BD49C";
      };
      cyan = {
        dark = "#28a8b1";
        default = "#41cfda";
        light = "#82eff7";
      };
      blue = {
        dark = "#1758b4";
        default = "#4589e7";
        light = "#86b8ff";
      };
      purple = {
        dark = "#522a80";
        default = "#7C3AED";
        light = "#C084FC";
      };
      pink = {
        dark = "#c43676";
        default = "#e75d9b";
        light = "#f896c2";
      };
      black = {
        dark = "#06060D";
        default = "#18181B";
        light = "#27272A";
      };
      gray = {
        dark = "#3F3F46";
        default = "#52525B";
        light = "#A1A1AA";
      };
      white = {
        dark = "#D4D4D8";
        default = "#E5E7EB";
        light = "#F8FAFC";
      };
    };

    font = rec {
      default = sans;
      serif = sans;
      sans = {
        name = "DejaVu Sans";
        pkg = pkgs.dejavu_fonts;
      };
      mono = {
        name = "DejaVu Sans Mono";
        pkg = pkgs.dejavu_fonts;
      };
      emoji = {
        name = "Noto Color Emoji";
        pkg = pkgs.noto-fonts-emoji;
      };
    };

    radius = {
      xs = 2;
      sm = 4;
      md = 8;
      lg = 12;
      xl = 16;
      full = 99999;
    };

    gap = {
      xs = 4;
      sm = 8;
      md = 12;
      lg = 18;
      xl = 24;
    };
  };
}