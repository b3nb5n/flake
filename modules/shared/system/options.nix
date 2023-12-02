args: let
  inherit (args.lib) mkOption types;
in mkOption {
  type = types.submodule {
    options = {
      name = mkOption { type = types.str; };
      arch-os = mkOption { type = types.str; };

      hardware = import ./hardware/options.nix args; 
    };
  };
}