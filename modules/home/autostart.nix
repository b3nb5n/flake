{ pkgs, lib, config, ... }:
let cfg = config.modules.autostart;
in {
  options = {
    modules.autostart = {
      enable = lib.mkEnableOption "autostart";
    };

    xdg.autostart = with lib.types; {
      packages = lib.mkOption {
        type = listOf package;
        default = [ ];
      };

      desktopItems = lib.mkOption {
        type = listOf package;
        default = [ ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "xdg.autoStart" pkgs lib.platforms.linux)
    ];

    xdg.configFile =
      let
        cfg = config.xdg.autostart;

        getDesktopItem = (pkg:
          if pkg ? desktopItem then pkg.desktopItem else
          if pkg ? desktopItems && pkg.desktopItems != [ ] then builtins.head pkg.desktopItems else
          abort "package '${pkg.pname}' is missing a desktop file"
        );

        pkgDesktopItems = builtins.map getDesktopItem cfg.packages;

        desktopItems = cfg.desktopItems ++ pkgDesktopItems;

        autostartEntry = item: lib.nameValuePair "autostart/${item.name}" {
          source = "${item}/share/applications/${item.name}";
        };
      in
      builtins.listToAttrs
        (builtins.map
          autostartEntry
          desktopItems);
  };
}
