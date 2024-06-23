{ ... }: {
  imports = [
    ../../modules/shared/themes/basic.nix
    ../../modules/shared/hardware/options.nix
  ];

  hardwareInfo.monitors = [
    {
      id = "0";
      name = "DP-1";
      x = 0;
      y = 0;
      width = 3440;
      height = 1440;
      rotation = 0;
      scale = 1.0;
    }
  ];
}
