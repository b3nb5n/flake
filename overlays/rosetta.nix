{ nixpkgs-unstable, firefox-darwin, ... }:
final: prev: {
  rosetta = 
  # if prev.system != "aarch64-darwin" then
  #   prev
  # else
    (import nixpkgs-unstable {
      inherit (prev) config;
      system = "x86_64-darwin";
      overlays = prev.overlays ++ [ firefox-darwin.overlay ];
    });
}
