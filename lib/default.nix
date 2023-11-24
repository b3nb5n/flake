args: {
  color = import ./color.nix args;
  hexToDec = import ./hex-to-dec.nix args;
  mapRec = import ./map-recursive.nix args;
  math = import ./math.nix args;
  theme = import ./theme.nix args;
}