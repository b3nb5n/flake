{ pkgs, lib, const, config, ... }: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file = let
    wallpaperPath = "~/${config.home.file.wallpapers.target}/treehouse.png";
  in {
    hyprpaperConfig = {
      target = ".config/hypr/hyprpaper.conf";
      text = ''
        # wallpaper = , ~/path_to_wallpaper

        ${lib.concatStrings
          (map
            (m: ''
              preload = ${wallpaperPath}
              wallpaper = ${m.name}, ${wallpaperPath}
            '')
            const.hardware.monitors)}
      '';
    };
  };
}