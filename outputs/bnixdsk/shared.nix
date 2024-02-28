{ ... }: {
  imports = [
    ../../modules/shared/themes/basic.nix
    ../../modules/shared/hardware/options.nix
  ];

  hardwareInfo.monitors = [
    {
      id = "1";
      name = "HDMI-A-1";
      x = 0;
      y = 0;
      width = 3440;
      height = 1440;
      rotation = 0;
      scale = 1.0;
    }
    {
      id = "0";
      name = "DP-1";
      x = 3440;
      y = -800;
      width = 3840;
      height = 2160;
      rotation = 90;
      scale = 1.5;
    }
  ];
}
