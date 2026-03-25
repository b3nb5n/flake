{ ... }: {
  flake.nixosModules.pipewire = { lib, config, ... }:
    let cfg = config.modules.pipewire;
    in {
      options.modules.pipewire = {
        enable = lib.mkEnableOption "pipewire";
      };

      config = lib.mkIf cfg.enable {
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
          wireplumber.enable = true;
        };
      };
    };
}

