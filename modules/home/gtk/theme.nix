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
}
