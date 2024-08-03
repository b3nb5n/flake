{ flakeInputs, pkgs, ... }: {
  imports = with flakeInputs.self.homeModules; [ eww hypr gtk local gui cli ];

  home = {
    stateVersion = "23.05";
    username = "ben";
    packages = with pkgs; [ inkscape lmms scarab prismlauncher ];
  };

  wayland.windowManager.hyprland.settings.monitor =
    [ "DP-2, 3840x2160, 0x0, 1.5" ];
}
