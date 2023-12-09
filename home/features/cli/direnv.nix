{ pkgs, config, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = config.programs.zsh.enable;
    config = {
      global.load_dotenv = true;
      whitelist.prefix = [
        "~/Projects"
      ];
    };
  };
  xdg.configFile."direnv/direnvrc".text = ''
    if [ -f "flake.nix" ] &&
      nix flake show --json | jq -e ".\"devShells\"" > /dev/null 2>&1;
    then
      use flake
    fi
  '';
}