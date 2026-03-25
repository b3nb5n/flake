{ self, ... }: {
  flake.homeModules.wbg = { pkgs, lib, config, ... }:
    let cfg = config.modules.wbg;
    in {
      options.modules.wbg = {
        enable = lib.mkEnableOption "wbg";

        wallpapersDir = lib.mkOption {
          type = lib.types.path;
          default =
            "${self.dotfiles.wallpapers}/.local/share/wallpapers";
        };

        wallpaper = lib.mkOption {
          type = lib.types.str;
          default = "mountain_pass.jpg";
        };
      };

      config = lib.mkIf cfg.enable {
        systemd.user.services.wbg = {
          Install.WantedBy = [ config.wayland.systemd.target ];

          Unit = {
            Description = "Desktop wallpaper";
            ConditionEnvironment = "WAYLAND_DISPLAY";
            After = [ config.wayland.systemd.target ];
            PartOf = [ config.wayland.systemd.target ];
          };

          Service = {
            ExecStart = ''
              ${pkgs.wbg}/bin/wbg --stretch "${cfg.wallpapersDir}/${cfg.wallpaper}"'';
            Restart = "always";
            RestartSec = "10";
          };
        };
      };
    };
}
