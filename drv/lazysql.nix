{ pkgs, ... }:
pkgs.buildGoModule {
  name = "lazysql";
  src = pkgs.fetchFromGitHub {
    owner = "jorgerojas26";
    repo = "lazysql";
    rev = "main";
    sha256 = "sNy/UukylA1Ew2f1zFqKG77XvIa0U8+QplLYyFTmNi0=";
  };
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ xorg.libX11.dev ];
  vendorHash = "sha256-tgD6qoCVC1ox15VPJWVvhe4yg3R81ktMuW2dsaU69rY=";
}
