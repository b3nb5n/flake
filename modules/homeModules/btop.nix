{ ... }: {
  flake.homeModules.btop = { pkgs, lib, config, ... }:
    let cfg = config.modules.btop;
    in {
      options.modules.btop = {
        enable = lib.mkEnableOption "btop";
        package = lib.mkPackageOption pkgs [ "btop" ] { };
      };

      config = lib.mkIf cfg.enable {
        home.packages = [ cfg.package ];

        xdg.configFile.btop.source = config.lib.file.mkOutOfStoreSymlink
          "${config.dotfiles.path}/btop/.config/btop";
      };
    };
}
