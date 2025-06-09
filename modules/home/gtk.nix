{ pkgs, lib, config, ... }:
let cfg = config.modules.gtk;
in {
  options.modules.gtk = {
    enable = lib.mkEnableOption "gtk";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        dejavu_fonts
        noto-fonts-emoji
        gtk-engine-murrine
        gnome-themes-extra
        sassc
      ];

      sessionVariables = {
        GTK_THEME = config.gtk.theme.name;
      };

      pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
        gtk.enable = true;
      };
    };

    gtk = rec {
      enable = true;
      theme = {
        package = pkgs.tokyonight-gtk-theme;
        name = "Tokyonight-Dark-BL";
      };
      iconTheme = {
        package = pkgs.tokyonight-gtk-theme;
        name = "Tokyonight-Dark";
      };

      gtk4.extraConfig = gtk3.extraConfig;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    };

    fonts.fontconfig.enable = true;

    xdg.configFile = (builtins.listToAttrs (builtins.map
      (version: rec {
        name = "gtk-${toString version}.0";
        value = {
          recursive = true;
          source =
            "${config.gtk.theme.package}/share/themes/Tokyonight-Dark/${name}";
        };
      }) [ 2 3 4 ]));
  };
}
