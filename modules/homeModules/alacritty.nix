{ ... }: {
  flake.homeModules.alacritty = { pkgs, lib, config, ... }:
    let cfg = config.modules.alacritty;
    in {
      options.modules.alacritty = {
        enable = lib.mkEnableOption "alacritty";
        package = lib.mkPackageOption pkgs [ "alacritty" ] { };

        autostart = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };
      };

      config = lib.mkIf cfg.enable {
        home.packages = [ cfg.package pkgs.nerd-fonts.atkynson-mono ];

        xdg = {
          configFile.alacritty.source = config.lib.file.mkOutOfStoreSymlink
            "${config.dotfiles.path}/alacritty/.config/alacritty";

          autostart.entries = lib.mkIf cfg.autostart
            [ "${cfg.package}/share/applications/Alacritty.desktop" ];
        };
      };
    };
}

