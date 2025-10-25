{ pkgs, lib, config, ... }:
let cfg = config.modules.gtk;
in {
  options.modules.gtk = {
    enable = lib.mkEnableOption "gtk";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
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

    gtk = {
      enable = true;

      theme = {
        package = pkgs.tokyonight-gtk-theme;
        name = "Tokyonight-Dark-BL";
      };

      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4.extraConfig.gtk-interface-color-scheme = 2;
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    xdg.dataFile."themes/Tokyonight-Dark-BL".source =
      "${config.gtk.theme.package}/share/themes/Tokyonight-Dark";
  };
}
