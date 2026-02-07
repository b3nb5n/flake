{ lib, config, ... }:
let cfg = config.modules.udiskie;
in {
  options.modules.udiskie = {
    enable = lib.mkEnableOption "udiskie";
  };

  config = lib.mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };
  };
}
