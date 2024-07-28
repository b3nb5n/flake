flakeInputs: pkgs: prev: {
  rosetta = (import flakeInputs.nixpkgs-unstable {
    inherit (pkgs) config;
    system = "x86_64-darwin";
    overlays = prev.overlays ++ [ flakeInputs.firefox-darwin.overlay ];
  });
}
