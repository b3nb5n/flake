{ pkgs, lib, config, ... }:
let cfg = config.modules.swayidle;
in {
  options.modules.swayidle = {
    enable = lib.mkEnableOption "swayidle";
    package = lib.mkPackageOption pkgs [ "swayidle" ] { };
  };

  config = lib.mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      package = cfg.package;

      timeouts = [{
        timeout = 300;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }];

      events = [{
        event = "before-sleep";
        command = "${pkgs.openrgb}/bin/openrgb -m direct -c 000000 -b 0";
      }];
    };
  };
}
