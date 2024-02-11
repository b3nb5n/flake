{ pkgs, ... }: {
  imports = [ ./gtk.nix ./hyprland.nix ./wofi.nix ];

  home.packages = with pkgs; [ xdg-utils ];
}
