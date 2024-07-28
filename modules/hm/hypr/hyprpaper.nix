{ config, ... }: {
  wayland.windowManager.hyprland.settings.exec-once =
    [ "${config.services.hyprpaper.package}/bin/hyprpaper" ];

  # services.hyprpaper = {
  #   enable = true;
  #   settings = let wallpaperPath = "~/${config.home.file.wallpaper.target}";
  #   in {
  #     preload = [ wallpaperPath ];
  #     wallpaper = ", ${wallpaperPath}";
  #   };
  # };
}
