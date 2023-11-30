{ lib, ... }: let
  inherit (lib) mkOption types;
in mkOption {
  type = listof mkOption {
    name = mkOption { type = types.str; };
    width = mkOption { type = types.int; };
    height = mkOption { type = types.int; };
    rotation = mkOption { type = types.int; default = 0; };
    scale = mkOption { type = types.float; default = 1.0; };
    positon = mkOption {
      type = types.submodule {
        options = {
          x = mkOption { type = types.int; };
          y = mkOption { type = types.int; };
        };
      };
      default = { x = 0; y = 0; };
    };
  };
}