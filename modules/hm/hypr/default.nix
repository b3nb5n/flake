{ pkgs, ... }: {
  imports = [ ./hyprland.nix ./hyprpaper.nix ];
  home.packages = with pkgs; [ hyprpicker playerctl ];
}
