{ pkgs, config, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = config.programs.zsh.enable;
    config = {
      global = {
        load_dotenv = true;
        disable_stdin = true;
        warn_timeout = "0s";
      };
      whitelist.prefix = [
        "~/Desktop"
      ];
    };
  };
  xdg.configFile."direnv/direnvrc".text = ''
    if [ -f "flake.nix" ] &&
      nix flake show --json 2> /dev/null |
        jq -e ".\"devShells\"" > /dev/null 2>&1;
    then
      use flake
    fi
  '';
}
