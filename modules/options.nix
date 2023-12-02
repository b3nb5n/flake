args: let
  inherit (args.lib) mkOption types;

  sharedOptions = {
    system = import ./shared/system/options.nix args;
    theme = import ./shared/theme/options.nix args;
  };
in {
  nixos.options.custom = mkOption {
    type = types.submodule {
      options = sharedOptions // {};
    };
  };

  hm.options.custom = mkOption {
    type = types.submodule {
      options = sharedOptions // {
        user = import ./hm/user/options.nix args;
      };
    };
  };
}