{ pkgs, ... }:
pkgs.rustPlatform.buildRustPackage {
  pname = "hyprland-workspaces";
  version = "1.2.5";
  src = pkgs.fetchFromGitHub {
    owner = "FieldofClay";
    repo = "hyprland-workspaces";
    rev = "v2.0.1";
    sha256 = "GhUjvFMlgjTdgtV9ASW7IqE2dBktPyOlRwg6qM1r7vc=";
  };

  cargoHash = "sha256-bK/nJocAhW8mIhx971zssdcW5qRUDciy2IHQcRESlv8=";
}
