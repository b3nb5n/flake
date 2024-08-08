{ flakeInputs, pkgs, ... }: {
  imports = with flakeInputs.self.homeModules; [
    eww
    hypr
    gtk
    local
    gui
    cli
    games
  ];

  home = {
    stateVersion = "23.05";
    username = "ben";
    packages = with pkgs; [ inkscape lmms lumafly kicad-unstable gimp ];
  };

  wayland.windowManager.hyprland.settings.monitor =
    [ "DP-2, 3840x2160, 0x0, 1.5" ];
}
