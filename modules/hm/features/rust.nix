{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    pkg-config
  ];
}