args: let
  inherit (args.lib) mkOption types;
in mkOption {
  type = types.listOf (types.submodule {
    options = {
      name = mkOption { type = types.str; };
      x = mkOption { type = types.int; };
      y = mkOption { type = types.int; };
      width = mkOption { type = types.int; };
      height = mkOption { type = types.int; };
      rotation = mkOption { type = types.int; };
      scale = mkOption { type = types.float; };
    };
  });
}