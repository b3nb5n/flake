flakeInputs: final: prev:
let args = { inherit (final) system config overlays; };
in {
  stable = (import flakeInputs.nixpkgs-stable args);
  unstable = (import flakeInputs.nixpkgs-unstable args);
}
