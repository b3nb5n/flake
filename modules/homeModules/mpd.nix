{ ... }: {
  flake.homeModules.mpd = { pkgs, lib, config, ... }:
    let cfg = config.modules.mpd;
    in {
      options.modules.mpd.enable = lib.mkEnableOption "mpd";

      config = lib.mkIf cfg.enable {
        systemd.user.services = {
          mpd = {
            Install.WantedBy = [ "default.target" ];
            Unit.After = [ "sound.target" ];

            Service = {
              Type = "notify";
              Environment = [ "PATH=${config.home.profileDirectory}/bin" ];
              ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon";
            };
          };

          mpd-mpris = {
            Install.WantedBy = [ "default.target" ];
            Unit.After = [ "mpd.service" ];

            Service = {
              Type = "dbus";
              BusName = "org.mpris.MediaPlayer2.mpd";
              ExecStart = "${pkgs.mpd-mpris}/bin/mpd-mpris -no-instance";
            };
          };
        };

        home.packages = with pkgs; [ mpd mpc rmpc ];

        xdg.configFile.mpd.source = config.lib.file.mkOutOfStoreSymlink
          "${config.dotfiles.path}/mpd/.config/mpd";
      };
    };
}
