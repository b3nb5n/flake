{ pkgs, ... }:
pkgs.rustPlatform.buildRustPackage {
  pname = "sic";
  version = "0.22.4";
  src = pkgs.fetchFromGitHub {
    owner = "foresterre";
    repo = "sic";
    rev = "v0.22.4";
    sha256 = "PFbHHO3m4mnV5s8DVev/iao9sC3FYht0whTHYzO25Yo=";
  };

  nativeBuildInputs = with pkgs; [ nasm ];
  cargoHash = "sha256-ZG4cNvxlDjglYXf3Ak2CGmSrh5et77iyDwUqjzv9eYw=";
}
