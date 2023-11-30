{ pkgs, const, usrLib, config, ... }: let
  isDarkTheme = usrLib.theme.isDarkTheme config.theme;
in {
  gtk = rec {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };

    gtk4.extraConfig = gtk3.extraConfig;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = isDarkTheme;
    };
  };

  home = {
    packages = with pkgs; [
      bibata-cursors
    ];
    pointerCursor = {
      name = if isDarkTheme then "Bibata-Modern-Classic" else "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
    };
  };

  xdg.configFile = rec {
    "gtk-4.0/gtk.css".text = gtkCss.text;
    gtkCss = {
      target = "gtk-3.0/gtk.css";
      text = with config.theme.color // usrLib.color; ''
        @define-color accent_color ${hex accent.default};
        @define-color accent_bg_color ${hex accent.default};
        @define-color accent_fg_color ${hex (builtins.elemAt bg 0)};
        @define-color destructive_color ${hex red.default};
        @define-color destructive_bg_color ${hex red.default};
        @define-color destructive_fg_color ${hex (builtins.elemAt bg 0)};
        @define-color success_color ${hex green.default};
        @define-color success_bg_color ${hex green.default};
        @define-color success_fg_color ${hex (builtins.elemAt bg 0)};
        @define-color warning_color ${hex yellow.default};
        @define-color warning_bg_color ${hex yellow.default};
        @define-color warning_fg_color ${hex (builtins.elemAt bg 0)};
        @define-color error_color ${hex red.default};
        @define-color error_bg_color ${hex red.default};
        @define-color error_fg_color ${hex (builtins.elemAt bg 0)};
        @define-color window_bg_color ${hex (builtins.elemAt bg 0)};
        @define-color window_fg_color ${hex (builtins.elemAt fg 0)};
        @define-color view_bg_color ${hex (builtins.elemAt bg 0)};
        @define-color view_fg_color ${hex (builtins.elemAt fg 0)};
        @define-color headerbar_bg_color ${hex (builtins.elemAt bg 1)};
        @define-color headerbar_fg_color ${hex (builtins.elemAt fg 0)};
        @define-color headerbar_border_color rgba(0, 0, 0, 0);
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
        @define-color card_bg_color ${hex (builtins.elemAt bg 1)};
        @define-color card_fg_color ${hex (builtins.elemAt fg 0)};
        @define-color card_shade_color rgba(0, 0, 0, 0.07);
        @define-color dialog_bg_color ${hex (builtins.elemAt fg 0)};
        @define-color dialog_fg_color ${hex (builtins.elemAt fg 0)};
        @define-color popover_bg_color ${hex (builtins.elemAt bg 1)};
        @define-color popover_fg_color ${hex (builtins.elemAt fg 0)};
        @define-color shade_color rgba(0, 0, 0, 0.07);
        @define-color scrollbar_outline_color ${hex (builtins.elemAt bg 2)};
        @define-color blue_1 ${hex blue.light};
        @define-color blue_2 ${hex blue.light};
        @define-color blue_3 ${hex blue.default};
        @define-color blue_4 ${hex blue.dark};
        @define-color blue_5 ${hex blue.dark};
        @define-color green_1 ${hex green.light};
        @define-color green_2 ${hex green.light};
        @define-color green_3 ${hex green.default};
        @define-color green_4 ${hex green.dark};
        @define-color green_5 ${hex green.dark};
        @define-color yellow_1 ${hex yellow.light};
        @define-color yellow_2 ${hex yellow.light};
        @define-color yellow_3 ${hex yellow.default};
        @define-color yellow_4 ${hex yellow.dark};
        @define-color yellow_5 ${hex yellow.dark};
        @define-color orange_1 ${hex orange.light};
        @define-color orange_2 ${hex orange.light};
        @define-color orange_3 ${hex orange.default};
        @define-color orange_4 ${hex orange.dark};
        @define-color orange_5 ${hex orange.dark};
        @define-color red_1 ${hex red.light};
        @define-color red_2 ${hex red.light};
        @define-color red_3 ${hex red.default};
        @define-color red_4 ${hex red.dark};
        @define-color red_5 ${hex red.dark};
        @define-color purple_1 ${hex purple.light};
        @define-color purple_2 ${hex purple.light};
        @define-color purple_3 ${hex purple.default};
        @define-color purple_4 ${hex purple.dark};
        @define-color purple_5 ${hex purple.dark};
        @define-color brown_1 ${hex pink.light};
        @define-color brown_2 ${hex pink.light};
        @define-color brown_3 ${hex pink.default};
        @define-color brown_4 ${hex pink.dark};
        @define-color brown_5 ${hex pink.dark};
        @define-color light_1 ${hex white.light};
        @define-color light_2 ${hex white.light};
        @define-color light_3 ${hex white.default};
        @define-color light_4 ${hex white.dark};
        @define-color light_5 ${hex white.dark};
        @define-color dark_1 ${hex black.light};
        @define-color dark_2 ${hex black.light};
        @define-color dark_3 ${hex black.default};
        @define-color dark_4 ${hex black.dark};
        @define-color dark_5 ${hex black.dark};
      '';
    };
  };
}