{ lib, config, ... }:
let cfg = config.modules.hyprpaper;
in {
  options = {
    modules.hyprpaper = {
      enable = lib.mkEnableOption "hyprpaper";
    };
  };

  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings =
        let wallpaperPath = builtins.toString ./wallpapers/mt-fuji.png;
        in {
          preload = [ wallpaperPath ];
          wallpaper = [ ", ${wallpaperPath}" ];
        };
    };
  };
}
