{ pkgs, ... }: pkgs.rustPlatform.buildRustPackage {
  pname = "hyprland-workspaces";
  version = "1.2.5";
  src = pkgs.fetchFromGitHub {
    owner = "FieldofClay";
    repo = "hyprland-workspaces";
    rev = "v1.2.5";
    sha256 = "";
  };

  cargoHash = "";
}