{ pkgs, lib, config, ... }:
let cfg = config.modules.gnome;
in {
  options.modules.gnome = {

    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        gnome-calculator
        gnome-calendar
        gnome-maps
        gnome-weather
      ];
    };

    xdg.desktopEntries = {
      gnomeMaps = {
        name = "Gnome Maps";
        genericName = "Maps";
        exec = "${pkgs.gnome-maps}/bin/gnome-maps";
      };
      gnomeWeather = {
        name = "Gnome Weather";
        genericName = "Weather";
        exec = "${pkgs.gnome-weather}/bin/gnome-weather";
      };
    };
  };
}
