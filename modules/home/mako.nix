{ pkgs, lib, config, ... }:
let cfg = config.modules.mako;
in {
  options.modules.mako = {
    enable = lib.mkEnableOption "mako";
    package = lib.mkPackageOption pkgs [ "mako" ] { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    dbus.packages = [ cfg.package ];
  };
}
