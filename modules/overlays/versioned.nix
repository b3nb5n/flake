{ inputs, ... }: {
  flake.overlays.versioned = final: _prev:
    let
      args = {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config overlays;
      };
    in {
      stable = import inputs.nixpkgs-stable args;
      unstable = import inputs.nixpkgs-unstable args;
      local = import <nixpkgs> args;
    };
}
