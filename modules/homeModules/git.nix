{ ... }: {
  flake.homeModules.git = { pkgs, lib, config, ... }:
    let cfg = config.modules.git;
    in {
      options.modules.git = { enable = lib.mkEnableOption "git"; };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ git lazygit ];

        xdg.configFile.git.source = config.lib.file.mkOutOfStoreSymlink
          "${config.dotfiles.path}/git/.config/git";
      };
    };
}
