flakeInputs: {
  rosetta = (import ./rosetta.nix flakeInputs);
  packages = (import ./packages.nix flakeInputs);
  nur = (import ./nur.nix flakeInputs);
}
