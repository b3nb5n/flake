{ ... }: {
  flake.homeModules.dotfiles = { lib, config, ... }: {
    options.dotfiles = {
      path = lib.mkOption {
        type = lib.types.path;
        default = "${config.home.homeDirectory}/.flake/dotfiles";
      };
    };
  };
}

