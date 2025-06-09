{ lib, config, ... }:
let cfg = config.modules.zsh;
in {
  options.modules.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = builtins.readFile ./zsh-prompt.zsh;
    };
  };
}
