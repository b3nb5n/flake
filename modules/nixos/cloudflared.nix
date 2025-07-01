{ lib, config, ... }:
let cfg = config.modules.cloudflared;
in {
  options.modules.cloudflared = {
    enable = lib.mkEnableOption "cloudflared";

    internalPort = lib.mkOption {
      type = lib.types.port;
      default = config.services.nginx.defaultHTTPListenPort;
    };
  };

  config = lib.mkIf cfg.enable {
    services.cloudflared = {
      enable = true;
      tunnels."bb6e0a55-8cfe-460c-8f0e-896d79e799ac" = {
        certificateFile = config.age.secrets.cloudflared-cert.path;
        credentialsFile = config.age.secrets.cloudflared-cred.path;
        default = "http_status:404";
        ingress = let proxyPath = "http://127.0.0.1:${cfg.internalPort}";
        in {
          "${config.networking.domain}" = proxyPath;
          "*.${config.networking.domain}" = proxyPath;
        };
      };
    };

    users.groups.cloudflared = { };
    users.users.cloudflared = {
      isSystemUser = true;
      group = config.users.groups.cloudflared.name;
    };

    age.secrets = let
      owner = {
        owner = config.users.users.cloudflared.name;
        group = config.users.groups.cloudflared.name;
      };
    in {
      cloudflared-cert = owner;
      cloudflared-cred = owner;
    };
  };
}
