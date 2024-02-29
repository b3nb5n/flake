{ pkgs, ... }:
pkgs.buildGoModule {
  name = "lazysql";
  src = pkgs.fetchFromGitHub {
    owner = "jorgerojas26";
    repo = "lazysql";
    rev = "v0.1.6";
    sha256 = "1qxYrzbtdVAxJ7WQf0IbMhGnF7tiw4gmqjAq7Ytd9z8=";
  };
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ xorg.libX11.dev ];
  vendorHash = "sha256-tgD6qoCVC1ox15VPJWVvhe4yg3R81ktMuW2dsaU69rY=";
}
