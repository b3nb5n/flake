{ pkgs, ... }: {
  home.packages = with pkgs.gnome; [
    gnome-maps
    gnome-weather
    gnome-disk-utility
  ];

  xdg.desktopEntries = {
    gnomeMaps = {
      name = "Gnome Maps";
      genericName = "maps";
      exec = "gnome-maps";
    };
    gnomeWeather = {
      name = "Gnome Weather";
      genericName = "weather";
      exec = "gnome-weather";
    };
  };
}
