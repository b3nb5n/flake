{ pkgs, lib, config, ... }:
let cfg = config.modules.git;
in {
  options.modules.git = {
    enable = lib.mkEnableOption "git";
    package = lib.mkPackageOption pkgs [ "self" "git" ] { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs = {
      gh = {
        enable = true;
        package = pkgs.writeShellScriptBin "gh" ''
          GH_TOKEN=$(cat ${config.age.secrets.github-token.path})
          "${pkgs.gh}/bin/gh" "$@"
        '';
      };

      lazygit.enable = true;
    };
  };
}
