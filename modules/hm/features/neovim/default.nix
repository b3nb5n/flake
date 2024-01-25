{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim

    nil
    lua-language-server
    stylua
    vscode-langservers-extracted
    vimPlugins.markdown-preview-nvim

    ripgrep
    yarn
    clang
    clangStdenv
    lazygit
  ];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
