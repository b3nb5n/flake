{ lib, config, ... }:
let cfg = config.modules.adguardhome;
in {
  options.modules.adguardhome = {
    enable = lib.mkEnableOption "adguardhome";
  };

  config = lib.mkIf cfg.enable {
    services.adguardhome = {
      enable = true;
      port = 6164;
      openFirewall = true;
    };

    networking = lib.mkIf config.services.adguardhome.enable {
      firewall = {
        allowedTCPPorts = [ config.services.adguardhome.port ];
        allowedUDPPorts = [ 53 ];
      };
    };
  };
}
