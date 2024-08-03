{ flakeInputs, pkgs, ... }: {
  imports = with flakeInputs.self.homeModules; [ eww hypr gtk local gui cli ];

  home = {
    stateVersion = "23.05";
    username = "ben";
    packages = with pkgs; [];
  };

  wayland.windowManager.hyprland.settings.monitor =
    [ "HDMI-A-1, 3840x2160, 0x0, 2" ];
}
