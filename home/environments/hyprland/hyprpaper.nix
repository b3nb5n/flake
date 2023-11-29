{ pkgs, lib, const, config, ... }: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file = let
    wallpaperPath = "~/${config.home.file.wallpapers.target}/waterfall_village_night.png";
  in {
    hyprpaperConfig = {
      target = ".config/hypr/hyprpaper.conf";
      text = ''
        ${lib.concatMapStrings
          (m: ''
            preload = ${wallpaperPath}
            wallpaper = ${m.name}, ${wallpaperPath}
          '')
          const.hardware.monitors}
      '';
    };
  };
}