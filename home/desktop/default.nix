{ pkgs, pkgsUnstable, config, hyprland, nix-colors, ... }: {
  imports = [
    ../base.nix
    ../apps/gui

    ./dunst.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./theme.nix
    ./waybar.nix
  ];
}