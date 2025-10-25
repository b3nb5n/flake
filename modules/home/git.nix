{ flakeInputs, pkgs, lib, config, ... }:
let cfg = config.modules.git;
in {
  options.modules.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ git lazygit ];

    programs.gh = {
      enable = true;
      package = pkgs.writeShellScriptBin "gh" ''
        GH_TOKEN=$(cat ${config.age.secrets.github-token.path})
        "${pkgs.gh}/bin/gh" "$@"
      '';
    };

    xdg.configFile.git.source =
      "${flakeInputs.self.dotfiles.git}/.config/git";
  };
}
