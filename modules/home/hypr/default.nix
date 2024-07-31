{ pkgs, ... }: {
  imports = [ ./hyprland.nix ./hyprpaper.nix ./hyprlock.nix ];
  home.packages = with pkgs; [ hyprpicker ];
}
