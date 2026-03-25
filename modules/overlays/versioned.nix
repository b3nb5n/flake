{ inputs, ... }: {
  flake.overlays.versioned = final: _prev:
    let
      args = {
        inherit (final) config overlays;
        inherit (final.stdenv.hostPlatform) system;
      };
    in {
      stable = import inputs.nixpkgs-stable args;
      unstable = import inputs.nixpkgs-unstable args;
      local = import <nixpkgs> args;
    };
}
