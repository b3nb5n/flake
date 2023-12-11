{ pkgs, ... }@args: {
  home.packages = with pkgs; [
    (callPackage ./workspace-listener.nix args)
  ];
}