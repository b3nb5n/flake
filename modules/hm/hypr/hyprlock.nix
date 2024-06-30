{ lib, config, ... }: {
  wayland.windowManager.hyprland.settings.exec-once = lib.mkBefore [
    ''if [ "$AUTO_LOGIN" = true ]; then ${config.programs.hyprlock.package}/bin/hyprlock --immediate; fi''
  ];

  programs.hyprlock = {
    enable = true;
    sourceFirst = true;
    settings = {
      general = {
        # grace = 10; # useful for testing but unsafe for auto login
        hide_cursor = true;
        disable_loading_bar = true;
        no_fade_in = true;
      };

      background = [{
        monitor = "";
        path = "~/${config.home.file.wallpaper.target}";
        color = "rgb(26, 27, 38)";
        blur_passes = 3;
        blur_size = 8;
      }];

      label = [{
        monitor = "";
        text = "$TIME";
        font_size = 64;
        valign = "center";
        halign = "center";
        text_align = "center";
        position = "0, 48";
      }];

      input-field = [{
        monitor = "";
        size = "256, 32";
        valign = "center";
        halign = "center";
        position = "0, -48";
        hide_empty = false;
        outline_thickness = 2;
      }];
    };
  };
}
