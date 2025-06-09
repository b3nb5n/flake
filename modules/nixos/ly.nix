{ pkgs, lib, config, ... }:
let cfg = config.modules.ly;
in {
  options.modules.ly = {
    enable = lib.mkEnableOption "ly";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        # animation = "matrix";
        clock = "%r %a, %b %d, %Y";
        clear_password = true;
        input_len = 36;
        numlock = true;
        text_in_center = true;
        # vi_mode = true;
        # vi_default_mode = "insert";
      };
    };
  };
}
