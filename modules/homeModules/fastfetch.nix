{ ... }: {
  flake.homeModules.fastfetch = { pkgs, lib, config, ... }:
    let cfg = config.modules.fastfetch;
    in {
      options.modules.fastfetch = { enable = lib.mkEnableOption "fastfetch"; };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ fastfetch ];

        xdg.configFile.fastfetch.source = config.lib.file.mkOutOfStoreSymlink
          "${config.dotfiles.path}/fastfetch/.config/fastfetch";
      };
    };
}
