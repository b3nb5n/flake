flakeInputs: prev: final: {
  nur = import flakeInputs.nur {
    pkgs = final;
    nurpkgs = final;
  };
}
