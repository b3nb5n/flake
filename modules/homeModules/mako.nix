{ ... }: {
  flake.homeModules.mako = { pkgs, lib, config, ... }:
    let cfg = config.modules.mako;
    in {
      options.modules.mako = {
        enable = lib.mkEnableOption "mako";
        package = lib.mkPackageOption pkgs [ "mako" ] { };
      };

      config = lib.mkIf cfg.enable {
        home.packages = [ cfg.package ];
        dbus.packages = [ cfg.package ];

        xdg.configFile.mako.source = config.lib.file.mkOutOfStoreSymlink
          "${config.dotfiles.path}/mako/.config/mako";
      };
    };
}
