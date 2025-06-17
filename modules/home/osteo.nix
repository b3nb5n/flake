{ pkgs, lib, config, ... }:
let cfg = config.modules.osteo;
in {
  options.modules.osteo = {
    enable = lib.mkEnableOption "osteo";
    package = lib.mkPackageOption pkgs [ "self" "osteo" ] { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ nixos-icons ];

    systemd.user.services.osteo = {
      Install.WantedBy = [ config.wayland.systemd.target ];

      Unit = {
        Description = "Desktop shell";
        ConditionEnvironment = "WAYLAND_DISPLAY";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart = "${cfg.package}/bin/osteo";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
