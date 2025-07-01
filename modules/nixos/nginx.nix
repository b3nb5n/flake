{ lib, config, ... }:
let cfg = config.modules.nginx;
in {
  options.modules.nginx.enable = lib.mkEnableOption "nginx";

  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
    };
  };
}
