{ config, ... }: {
  networking = {
    firewall = {
      allowedTCPPorts = [ config.services.adguardhome.port ];
      allowedUDPPorts = [ 53 ];
    };
  };

  services.adguardhome = {
    enable = true;
    port = 6164;
    openFirewall = true;
  };
}
