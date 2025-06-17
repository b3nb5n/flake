{ pkgs, lib, config, ... }:
let
  cfg = config.modules.neovim;
  nvimPath = "${cfg.package}/bin/nvim";
in {
  options.modules.neovim = {
    enable = lib.mkEnableOption "neovim";
    package = lib.mkPackageOption pkgs [ "self" "neovim" ] { };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ cfg.package ];
      sessionVariables = {
        EDITOR = nvimPath;
        SPAWNEDITOR = nvimPath;
        VISUAL = nvimPath;
      };
    };

    programs = rec {
      bash.shellAliases = zsh.shellAliases;
      zsh.shellAliases = {
        vi = nvimPath;
        vim = nvimPath;
      };
    };
  };
}
