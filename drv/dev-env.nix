{ pkgs, usrDrv, ... }:
pkgs.buildEnv {
  name = "development-env";
  paths = with pkgs // usrDrv; [
    neovim
    gawk
    curl
    openssl
    ripgrep
    locale
    git
    gh
    lazygit
    lazydocker
    lazysql
    wuzz
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" "rustfmt" ];
    })
    zig
  ];
}
