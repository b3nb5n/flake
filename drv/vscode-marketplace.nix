{ pkgs, ... }:
(import (pkgs.fetchFromGitHub {
  owner = "nix-community";
  repo = "nix-vscode-extensions";
  rev = "master";
  sha256 = "jLEVnMZBxZ/0ziOvzrM9t5NvrwYFvhWLG9lh+ZS6Hhs=";
})).extensions.${pkgs.system}.vscode-marketplace
