{ pkgs, lib, config, ... }:
let cfg = config.modules.ssh;
in {
  options.modules.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      hashKnownHosts = true;
      matchBlocks = {
        # bnixdsk = {
        #   hostname = pkgs.usrLib.readSecretUnsafe "hosts/bnixdsk/public_ip.age";
        #   port = pkgs.lib.toInt (pkgs.usrLib.readSecretUnsafe "hosts/bnixdsk/public_port.age");
        # };
      };
    };
  };
}
