{ pkgs, lib, config, ... }:
let cfg = config.modules.direnv;
in {
  options.modules.direnv = {
    enable = lib.mkEnableOption "direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableZshIntegration = config.programs.zsh.enable;

      config = {
        global = {
          load_dotenv = true;
          disable_stdin = true;
          warn_timeout = "0s";
        };
        whitelist.prefix = [
          config.xdg.userDirs.desktop
        ];
      };
    };

    xdg.configFile."direnv/direnvrc".text = ''
      if [ -f "./.flake/flake.nix" ] &&
        nix flake show 'path:./.flake' --json 2> /dev/null |
          ${pkgs.jq}/bin/jq -e ".\"devShells\"" > /dev/null 2>&1;
      then
        use flake 'path:./.flake'
      fi
    '';

    programs.git.ignores = [
      ".direnv"
      ".flake"
    ];
  };
}
