{ config, ... }: {
  services.hyprpaper = {
    enable = true;
    settings =
      let wallpaperPath = "~/${config.home.file.wallpaper.target}";
      in {
        preload = [ wallpaperPath ];
        wallpaper = map
          (m: "${m.name}, ${wallpaperPath}")
          config.hardwareInfo.monitors;
      };
  };
}
