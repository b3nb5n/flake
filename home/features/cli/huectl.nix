{ pkgs, ... }: let
  huectl = pkgs.rustPlatform.buildRustPackage {
    pname = "huectl";
    version = "0.5.2";
    src = pkgs.fetchFromGitHub {
      owner = "nn1ks";
      repo = "huectl-rs";
      rev = "master";
      sha256 = "OMWCcXeXisnsbb57yLIePoOyJwwPuvTlKonQn4Xbi+4=";
    };

    cargoHash = "sha256-3NFG+WdiAwGELZrR1IH6JpXG7V9K5o/BbZJRq5SnLBo=";
  };
in {
  home.packages = with pkgs; [
    huectl
  ];
}