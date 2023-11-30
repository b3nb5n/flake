{ lib, ... }: let
  inherit (lib) mkOption types;
in mkOption {
  type = types.submodule {
    options = {
      name = mkOption { type = types.str; };
      email = mkOption { type = type.string; };
    };
  };
}