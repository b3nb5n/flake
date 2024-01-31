{ lib, ... }@args: rec {
  color = r: g: b: { inherit r g b; };

  parseHex = hexStr:
    let
      hexToDec = import ./hex-to-dec.nix args;

      hex = lib.strings.removePrefix "#" hexStr;
      r = hexToDec (builtins.substring 0 2 hex);
      g = hexToDec (builtins.substring 2 2 hex);
      b = hexToDec (builtins.substring 4 2 hex);
    in color r g b;

  hexChannel = c:
    let
      str = "0${lib.trivial.toHexString c}";
      len = builtins.stringLength str;
    in builtins.substring (len - 2) 2 str;

  hex = { r, g, b }: "#${hexChannel r}${hexChannel g}${hexChannel b}";
  hexA = color: a: "${hex color}${hexChannel (builtins.ceil (a * 255))}";

  rgba = { r, g, b }:
    a:
    "rgba(${toString r}, ${toString g}, ${toString b}, ${toString a})";

  channelAvg = color:
    let
      values = (lib.attrsets.attrValues color);
      sum = builtins.foldl' builtins.add 0 values;
      n = builtins.length values;
    in sum / n;
}
