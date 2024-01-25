args: {
  color = import ./color.nix args;
  hexToDec = import ./hex-to-dec.nix args;
  lua = import ./lua.nix args;
  mapRec = import ./map-recursive.nix args;
  math = import ./math.nix args;
  mergeRec = import ./merge-recursive.nix args;
  theme = import ./theme.nix args;
}