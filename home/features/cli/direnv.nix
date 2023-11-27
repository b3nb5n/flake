{ pkgs, ... }: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    config = {
      global.load_dotenv = true;
      whitelist.prefix = [
        "~/Projects"
      ];
    };
  };
}