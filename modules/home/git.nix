{ pkgs, lib, config, ... }:
let cfg = config.modules.git;
in {
  options.modules.git = {
    enable = lib.mkEnableOption "git";
    package = lib.mkPackageOption pkgs [ "self" "git" ] { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # age.secrets.github-token.file =
    #   pkgs.usrLib.flakeRoot
    #     "secrets/users/${config.home.username}/github_token.age";

    programs.gh = {
      enable = true;
      # package = pkgs.writeShellScriptBin "gh" ''
      #   GH_TOKEN=$(cat ${config.age.secrets.github-token.path})
      #   "${pkgs.gh}/bin/gh" "$@"
      # '';
    };

    programs.lazygit.enable = true;

    xdg.configFile."lazygit/config.yml".text = (builtins.readFile
      "${pkgs.self.tokyonight}/extras/lazygit/tokyonight_night.yml");
  };
}
