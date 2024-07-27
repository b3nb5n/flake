{ ... }: {
  imports = [
    ../../modules/shared/themes/basic.nix
    ../../modules/shared/hardware/options.nix
  ];

  hardwareInfo.monitors = [{
    id = "0";
    name = "eDP-1";
    x = 0;
    y = 0;
    width = 1920;
    height = 1080;
    rotation = 0;
    scale = 1.0;
  }];
}
