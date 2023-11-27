{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./blueberry.nix
    ./firefox.nix
    ./hyprpicker.nix
    ./inkscape.nix
    ./nemo.nix
    ./spotify.nix
    ./vscode.nix
  ];
}