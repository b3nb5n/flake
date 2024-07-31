flakeInputs: final: prev: {
  rosetta = if (final.system == "aarch64-darwin") then
    (import flakeInputs.nixpkgs-unstable {
      inherit (final) config;
      system = "x86_64-darwin";
      overlays = final.overlays ++ [ flakeInputs.firefox-darwin.overlay ];
    })
  else
    final;
}
