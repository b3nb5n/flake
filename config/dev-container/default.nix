{ pkgs, ... }@args: {
  dockerContainers.dev-container = pkgs.dockerTools.buildNixShellImage {
    drv = pkgs.mkShell { packages = [ (import ../../drv/neovim args) ]; };
  };
}
