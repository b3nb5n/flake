{ ... }: {
  imports = [
    ../base.nix

    ./dunst.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./theme.nix
    ./waybar.nix
    ./wofi.nix
  ];
}