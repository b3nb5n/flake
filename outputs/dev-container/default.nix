{ pkgs, repos, ... }: {
  dockerContainers.dev-container = pkgs.dockerTools.buildLayeredImage {
    name = "dev-container";
    config.Cmd = [ "${pkgs.zsh}/bin/zsh" "-i" ];
    contents = with pkgs // repos.usrDrv; [ coreutils-full bash zsh ];
  };
}

# { pkgs, usrDrv, ... }:
# pkgs.buildEnv {
#   name = "development-env";
#   paths = with pkgs // usrDrv; [
#     neovim
#     gawk
#     curl
#     openssl
#     ripgrep
#     locale
#     git
#     gh
#     lazygit
#     lazydocker
#     lazysql
#     wuzz
#     (rust-bin.stable.latest.default.override {
#       extensions = [ "rust-src" "rustfmt" ];
#     })
#     zig
#   ];
# }
