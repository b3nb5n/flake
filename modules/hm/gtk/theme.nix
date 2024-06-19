{ pkgs, usrLib, config, ... }: {
  home.packages = with pkgs; [ gtk-engine-murrine gnome-themes-extra sassc ];

  gtk = rec {
    enable = true;
    theme = {
      package = pkgs.tokyo-night-gtk;
      name = "Tokyonight-Dark-BL";
    };

    gtk4.extraConfig = gtk3.extraConfig;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = usrLib.theme.isDarkTheme config.theme;
    };
  };
}
