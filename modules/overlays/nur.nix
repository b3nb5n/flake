{ inputs, ... }: {
  flake.overlays.nur = final: _prev: {
    nur = import inputs.nur {
      pkgs = final;
      nurpkgs = final;
    };
  };
}
