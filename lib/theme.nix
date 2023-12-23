{ nixpkgs-stable, ... }@args: let
  inherit (nixpkgs-stable) lib;
in rec {
  isDarkTheme = theme: let
    colorusrLib = import ./color.nix args;
  in colorusrLib.channelAvg (builtins.elemAt theme.color.bg 0) <
    colorusrLib.channelAvg (builtins.elemAt theme.color.fg 0);
  
  isLightTheme = theme: !(isDarkTheme theme);
}