{ lib, ... }@args: let
  inherit (lib) mkOption types;
in mkOption {
  type = types.submodule {
    options = {
      monitors = import ./monitors/options.nix args;
    };
  };
}