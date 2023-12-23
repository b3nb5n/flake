{ lib, ... }@args: let
  inherit (lib) mkOption types;
in {
  options.hardwareInfo = mkOption {
    type = types.submodule {
      options = {
        monitors = import ./monitors/options.nix args;
      };
    };
  };
}