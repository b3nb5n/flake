{ const, utils, ... }: {
  gtk = rec {
    enable = true;

    gtk4.extraConfig = gtk3.extraConfig;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = const.theme.dark;
    };
  };

  xdg.configFile = rec {
    "gtk-4.0/gtk.css".text = gtk3Styles.text; 
    gtk3Styles = {
      target = "gtk-3.0/gtk.css";
      text = with const.theme.colors // utils.theme; ''
        @define-color accent_color #${hex base0A};
        @define-color accent_bg_color #${hex base0A};
        @define-color accent_fg_color #${hex base00};
        @define-color destructive_color #${hex base08};
        @define-color destructive_bg_color #${hex base08};
        @define-color destructive_fg_color #${hex base00};
        @define-color success_color #${hex base0B};
        @define-color success_bg_color #${hex base0B};
        @define-color success_fg_color #${hex base00};
        @define-color warning_color #${hex base0E};
        @define-color warning_bg_color #${hex base0E};
        @define-color warning_fg_color #${hex base00};
        @define-color error_color #${hex base08};
        @define-color error_bg_color #${hex base08};
        @define-color error_fg_color #${hex base00};
        @define-color window_bg_color #${hex base00};
        @define-color window_fg_color #${hex base05};
        @define-color view_bg_color #${hex base00};
        @define-color view_fg_color #${hex base05};
        @define-color headerbar_bg_color #${hex base01};
        @define-color headerbar_fg_color #${hex base05};
        @define-color headerbar_border_color ${rgba base01 0.8};
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_shade_color ${rgba base00 0.8};
        @define-color card_bg_color #${hex base01};
        @define-color card_fg_color #${hex base05};
        @define-color card_shade_color ${rgba base00 0.8};
        @define-color dialog_bg_color #${hex base01};
        @define-color dialog_fg_color #${hex base05};
        @define-color popover_bg_color #${hex base01};
        @define-color popover_fg_color #${hex base05};
        @define-color shade_color ${rgba base00 0.8};
        @define-color scrollbar_outline_color #${hex base02};
      ''; 
    };
  };
}