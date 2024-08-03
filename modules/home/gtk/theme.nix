{ pkgs, config, ... }: {
  home = {
    sessionVariables.GTK_THEME = config.gtk.theme.name;
    packages = with pkgs; [ gtk-engine-murrine gnome-themes-extra sassc ];
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

  xdg.configFile = (builtins.listToAttrs (builtins.map (version: rec {
    name = "gtk-${toString version}.0";
    value = {
      recursive = true;
      source =
        "${config.gtk.theme.package}/share/themes/Tokyonight-Dark/${name}";
    };
  }) [ 2 3 4 ]));
}
