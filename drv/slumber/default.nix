{ pkgs, ... }:
pkgs.rustPlatform.buildRustPackage {
  pname = "slumber";
  version = "v0.12.1";
  src = pkgs.fetchFromGitHub {
    owner = "LucasPickering";
    repo = "slumber";
    rev = "v0.12.1";
    sha256 = "CZAROtOj0fUPZnmIWEuqhWCv8++hNH9KF+Sz6x813E8=";
  };

  cargoHash = "sha256-RS8/tO+h7+9MWqzgZqIjrAC8279E94y+mGNlcSB1AXE=";
}
