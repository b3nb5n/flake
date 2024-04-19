{ pkgs, ... }:
(import (pkgs.fetchFromGitHub {
  owner = "nix-community";
  repo = "nix-vscode-extensions";
  rev = "master";
  sha256 = "A2s6Mx1oXZFFjZGrPIJpOGfZnQpKlBEEADIjLe1dPqY=";
})).extensions.${pkgs.system}.vscode-marketplace
