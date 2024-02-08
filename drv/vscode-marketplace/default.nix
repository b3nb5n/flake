{ pkgs, ... }:
(import (pkgs.fetchFromGitHub {
  owner = "nix-community";
  repo = "nix-vscode-extensions";
  rev = "master";
  sha256 = "lbioI+/sipflPD0XmJOjYfCioPIg/3cRo87l4hp6i7s=";
})).extensions.${pkgs.system}.vscode-marketplace
