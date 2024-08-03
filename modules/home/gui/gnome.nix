{ pkgs, ... }: {
  home = {
    packages = with pkgs.gnome // pkgs; [
      nautilus
      gnome-calculator
      gnome-calendar
      gnome-maps
      gnome-weather
      gnome-disk-utility
      blueberry
    ];
  };

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
