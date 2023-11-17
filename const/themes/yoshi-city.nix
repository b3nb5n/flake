{ utils, ... }: {
  dark = true;

  colors = with utils.theme; {
    base00 = color 23 29 35;
    base01 = color 29 37 44;
    base02 = color 40 50 58;
    base03 = color 82 98 112;
    base04 = color 183 197 211;
    base05 = color 216 226 236;
    base06 = color 246 246 248; 
    base07 = color 251 251 253; 
    base08 = color 217 84 104; 
    base09 = color 255 158 100;
    base0A = color 235 191 131; 
    base0B = color 139 212 156;
    base0C = color 112 225 232;
    base0D = color 83 154 252;
    base0E = color 182 45 101;
    base0F = color 221 157 130;
  };

  fonts = rec {
    default = sans;
    serif = "DejaVu Serif";
    sans = "DejaVu Sans";
    mono = "DejaVu Sans Mono";
    emoji = "Noto Color Emoji";
  };
}