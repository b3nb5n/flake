{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./blueberry.nix
    ./firefox.nix
    ./hyprpicker.nix
    ./inkscape.nix
    ./lmms.nix
    ./nemo.nix
    ./spotify.nix
    ./vscode.nix
  ];
}