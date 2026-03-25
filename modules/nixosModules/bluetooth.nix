{ ... }: {
  flake.nixosModules.bluetooth = { lib, config, ... }:
    let cfg = config.modules.bluetooth;
    in {
      options.modules.bluetooth = {
        enable = lib.mkEnableOption "bluetooth";
      };

      config = lib.mkIf cfg.enable {
        hardware.bluetooth = {
          enable = true;
          powerOnBoot = true;
          settings.General.ControllerMode = "bredr";
        };
      };
    };
}
