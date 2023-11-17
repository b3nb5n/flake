{ lib, ... }: {
  color = r: g: b: {
    inherit r;
    inherit g;
    inherit b;
  }; 

  hex = let
    channel = c: let
      str = "0${lib.trivial.toHexString c}";
      len = builtins.stringLength str;
    in builtins.substring (len - 2) 2 str;
  in { r, g, b }: "${channel r}${channel g}${channel b}";

  rgba = { r, g, b }: a: "rgba(${toString r}, ${toString g}, ${toString b}, ${toString a})";
}