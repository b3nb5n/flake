flakeInputs: final: prev: {
  nur = import flakeInputs.nur {
    pkgs = final;
    nurpkgs = final;
  };
}
