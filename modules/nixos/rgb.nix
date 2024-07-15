{ config, ... }: {
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  # systemd.services.openrgb.postStart =
  #   "${config.services.hardware.openrgb.package}/bin/openrgb -m static -c FF00FF -b 100";

  boot.kernelParams = [ "acpi_enforce_resources=lax" ];
}
