{ ... }: {
  flake.homeModules.zsh = { pkgs, lib, config, ... }:
    let
      cfg = config.modules.zsh;
      dotfiles = "${config.dotfiles.path}/zsh";
    in {
      options.modules.zsh = {
        enable = lib.mkEnableOption "zsh";
      };

      config = lib.mkIf cfg.enable {
        home = {
          packages = with pkgs; [ zsh ];

          file = {
            ".zshenv".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshenv";
            ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";
          };
        };

        xdg = {
          configFile.zsh.source =
            config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/zsh";

          dataFile.zsh-plugins = {
            target = "zsh/plugins";
            source = config.lib.file.mkOutOfStoreSymlink
              "${dotfiles}/.local/share/zsh/plugins";
          };
        };
      };
    };
}
