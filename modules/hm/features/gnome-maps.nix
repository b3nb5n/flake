{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome.gnome-maps
  ];

  xdg.desktopEntries.gnomeMaps = {
    name = "Gnome Maps";
    genericName = "maps";
    exec = "gnome-maps";
  };
}