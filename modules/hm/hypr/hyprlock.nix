{ config, ... }: {
  programs.hyprlock = {
    enable = true;
    sourceFirst = true;
    settings = {
      general = {
        # grace = 10; # useful for testing but unsafe for auto login
        hide_cursor = true;
      };

      background = [{
        monitor = "";
        path = "~/${config.home.file.wallpaper.target}";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        monitor = "";
        size = "200, 50";
        valign = "center";
        halign = "center";
      }];
    };
  };
}
