{ pkgs, ... }: {
  imports = [
    ../base

    ./eww
    ./gtk.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./wofi.nix
  ];
}