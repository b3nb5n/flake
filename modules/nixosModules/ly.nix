{ ... }: {
  flake.nixosModules.ly = { lib, config, ... }:
    let cfg = config.modules.ly;
    in {
      options.modules.ly = {
        enable = lib.mkEnableOption "ly";
      };

      config = lib.mkIf cfg.enable {
        systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP =
          "X-NIXOS-SYSTEMD-AWARE";

        services.displayManager.ly = {
          enable = true;
          settings = {
            clock = "%r %a, %b %d, %Y";
            clear_password = true;
            input_len = 36;
            numlock = true;
            text_in_center = true;
          };
        };
      };
    };
}
