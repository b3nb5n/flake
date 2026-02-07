{ pkgs, lib, config, ... }:
let cfg = config.modules.spotify;
in {
  options.modules.spotify = {
    enable = lib.mkEnableOption "spotify";
    package = lib.mkPackageOption pkgs [ "stable" "spotify" ] { };

    autostart = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.autostart.entries = lib.mkIf cfg.autostart [
      "${cfg.package}/share/applications/spotify.desktop"
    ];
  };
}
