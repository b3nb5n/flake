{ lib, config, ... }:
let cfg = config.modules.openrgb;
in {
  options.modules.openrgb = {
    enable = lib.mkEnableOption "openrgb";
  };

  config = lib.mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };

    boot.kernelParams = [ "acpi_enforce_resources=lax" ];

    systemd.services.openrgb =
      let openrgb = "${config.services.hardware.openrgb.package}/bin/openrgb";
      in {
        # postStart = "${openrgb} -m direct -c 0000FF";
        preStop = "${openrgb} -m direct -c 000000";
      };
  };
}
