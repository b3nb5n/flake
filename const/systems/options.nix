{ lib, ... }: let
  inherit (lib) mkOption types;
in mkOption {
  type = types.submodule {
    options = {
      name = mkOption { type = types.str; };
      arch-os = mkOption { type = types.str; };
    };
  };
}