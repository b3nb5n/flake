flakeInputs: final: prev:
let
  args = {
    inherit (final) config overlays;
    inherit (final.stdenv.hostPlatform) system;
  };
in {
  stable = import flakeInputs.nixpkgs-stable args;
  unstable = import flakeInputs.nixpkgs-unstable args;
  local = import <nixpkgs> args;
}
