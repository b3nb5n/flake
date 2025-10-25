{ pkgs, lib, config, ... }:
let cfg = config.modules.zsh;
in {
  options.modules.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;

  };
}
