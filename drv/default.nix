args: {
  hyprland-workspaces = import ./hyprland-workspaces.nix args;
  lazysql = import ./lazysql.nix args;
  neovim = import ./neovim.nix args;
  sic = import ./sic.nix args;
  vscode-marketplace = import ./vscode-marketplace.nix args;
}
