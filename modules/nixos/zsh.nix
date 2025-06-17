{ pkgs, lib, config, ... }:
let cfg = config.modules.zsh;
in {
  options.modules.zsh = {
    enable = lib.mkEnableOption "zsh";
    package = lib.mkPackageOption pkgs [ "self" "zsh" ] { };
  };

  config = lib.mkIf cfg.enable {
    users.defaultUserShell = cfg.package;

    environment = {
      systemPackages = [ cfg.package ];
      shells = [ "${cfg.package}/bin/zsh" ];
    };
  };
}
