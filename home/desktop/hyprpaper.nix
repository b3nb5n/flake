{ pkgs, ... }: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file = rec {
    wallpaper = {
      source = ./backgrounds/treehouse.png;
      target = ".local/share/wallpaper.png";
    };

    hyprpaperConfig = {
      target = ".config/hypr/hyprpaper.conf";
      text = ''
        preload = ~/${wallpaper.target}
        wallpaper = HDMI-A-1, ~/${wallpaper.target}
      '';
    };
  };
}