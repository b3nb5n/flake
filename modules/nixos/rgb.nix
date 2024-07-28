{ config, ... }: {
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  systemd.services.openrgb =
    let openrgb = "${config.services.hardware.openrgb.package}/bin/openrgb";
    in {
      # postStart = "${openrgb} -m direct -c 0000FF";
      preStop = "${openrgb} -m direct -c 000000";
    };

  boot.kernelParams = [ "acpi_enforce_resources=lax" ];
}
