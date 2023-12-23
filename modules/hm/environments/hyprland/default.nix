{ pkgs, ... }: {
  imports = [
    ./eww
    ./gtk.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./wofi.nix
  ];
}