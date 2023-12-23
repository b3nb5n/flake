{ nixpkgs-stable, ... }@args: hex: let
  hexToDecMap = {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
    "a" = 10;
    "b" = 11;
    "c" = 12;
    "d" = 13;
    "e" = 14;
    "f" = 15;
  };

  inherit (nixpkgs-stable) lib;
  math = import ./math.nix args;
  base16To10 = exponent: scalar: scalar * math.pow 16 exponent;
  
  decimals = builtins.map (ch: hexToDecMap."${ch}") (lib.strings.stringToCharacters (lib.strings.toLower hex));
  decimalsAscending = lib.lists.reverseList decimals;
  decimalsPowered = lib.lists.imap0 base16To10 decimalsAscending;
in lib.lists.foldl builtins.add 0 decimalsPowered