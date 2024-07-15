{ ... }: {
  imports = [
    ../../modules/shared/themes/basic.nix
    ../../modules/shared/hardware/options.nix
  ];

  hardwareInfo.monitors = [
    {
      id = "0";
      name = "DP-2";
      x = 0;
      y = 0;
      width = 3840;
      height = 2160;
      rotation = 0;
      scale = 1.5;
    }
  ];
}
