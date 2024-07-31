flakeInputs: {
  dirIndex = import ./dir-index.nix flakeInputs;
  mergeRec = import ./merge-recursive.nix flakeInputs;
  path = import ./path.nix flakeInputs;
}
