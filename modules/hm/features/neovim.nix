{ pkgs, ... }: {
  xdg.configFile.nvim.source = pkgs.fetchgit {
    url = "https://github.com/b3nb5n/neovim-config";
    leaveDotGit = true;
    hash = "sha256-SZesmy2DcE+lMmi4Yl3ElU1TEeJYZnHHpAM1uVDyTtA=";
  };
}