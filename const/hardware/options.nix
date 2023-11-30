{ lib, ... }@args: let
  inherit (lib) mkOption types;
in mkOption {
  type = submodule {
    options = {
      monitors = import ./monitors/options.nix args;
    };
  };
}