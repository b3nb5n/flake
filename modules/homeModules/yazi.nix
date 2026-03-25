{ ... }: {
  flake.homeModules.yazi = { pkgs, lib, config, ... }:
    let cfg = config.modules.yazi;
    in {
      options.modules.yazi = { enable = lib.mkEnableOption "yazi"; };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ yazi ouch mediainfo ];

        xdg.configFile.yazi.source = config.lib.file.mkOutOfStoreSymlink
          "${config.dotfiles.path}/yazi/.config/yazi";
      };
    };
}
