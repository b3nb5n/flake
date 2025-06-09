{ pkgs, lib, config, ... }:
let cfg = config.modules.alacritty;
in {
  options.modules.alacritty = {
    enable = lib.mkEnableOption "alacritty";
    package = lib.mkPackageOption pkgs [ "self" "alacritty" ] { };
  };

  config = lib.mkIf cfg.enable {
    home = {
      sessionVariables.TERMINAL = "${cfg.package}/bin/alacritty";
      packages = [ cfg.package ];
    };

    xdg.autostart.desktopItems = [
      (pkgs.makeDesktopItem {
        name = "alacritty";
        desktopName = "Alacritty";
        type = "Application";
        exec = "${cfg.package}/bin/alacritty";
      })
    ];
  };
}
