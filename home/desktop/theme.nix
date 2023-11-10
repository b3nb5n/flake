{ pkgs, config, nix-colors, ... }: let
  colors-lib = nix-colors.lib.contrib { inherit pkgs; };

  gtkConfig = {
    gtk-application-prefer-dark-theme = true;
  };
in {
  imports = [
    nix-colors.homeManagerModule
  ];

  colorScheme = colors-lib.colorSchemeFromPicture {
    path = config.home.file.wallpaper.source;
    kind = "dark";
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = gtkConfig;
    gtk4.extraConfig = gtkConfig;
  };
}