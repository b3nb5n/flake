{ pkgs, ... }:
pkgs.buildGoModule {
  name = "lazysql";
  src = pkgs.fetchFromGitHub {
    owner = "jorgerojas26";
    repo = "lazysql";
    rev = "v0.1.8";
    sha256 = "yPf9/SM4uET/I8FsDU1le9JgxELu0DR9k7mv8PnBwvQ=";
  };
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ xorg.libX11.dev ];
  vendorHash = "sha256-tgD6qoCVC1ox15VPJWVvhe4yg3R81ktMuW2dsaU69rY=";
}
