{ utils, ... }: {
  dark = true;

  colors =  with utils.theme; {
    base00 = color 23 23 38;
    base01 = color 34 39 61;
    base02 = color 82 88 102;
    base03 = color 135 141 150;
    base04 = color 200 200 200;
    base05 = color 255 255 255;
    base06 = color 255 255 255; 
    base07 = color 255 255 255; 
    base08 = color 250 120 131; 
    base09 = color 255 195 135;
    base0A = color 255 148 112; 
    base0B = color 152 195 121;
    base0C = color 138 245 255;
    base0D = color 107 184 255;
    base0E = color 231 153 255;
    base0F = color 179 104 79;
  };

  fonts = rec {
    default = sans;
    serif = "DejaVu Serif";
    sans = "DejaVu Sans";
    mono = "DejaVu Sans Mono";
    emoji = "Noto Color Emoji";
  };
}
