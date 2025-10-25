{ flakeInputs, pkgs, lib, config, ... }:
let
  cfg = config.modules.zsh;
  dotfiles = flakeInputs.self.dotfiles.zsh;
in {
  options.modules.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [ zsh ];

      file = {
        ".zshenv".source = "${dotfiles}/.zshenv";
        ".zshrc".source = "${dotfiles}/.zshrc";
      };
    };

    xdg.configFile.zsh.source =
      "${flakeInputs.self.dotfiles.zsh}/.config/zsh";
  };
}
