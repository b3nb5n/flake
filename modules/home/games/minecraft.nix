{ pkgs, ... }: {
  home.packages = with pkgs; [ prismlauncher ];
  home.file.prismTheme = {
    recursive = true;
    target = ".local/share/PrismLauncher/themes";
    source = pkgs.fetchzip {
      url =
        "https://github.com/PrismLauncher/Themes/releases/latest/download/Tokyo-Night-theme.zip";
      sha256 = "TcasVX7PHDhgZB9M/wHBffW7eQXtef+qB2nrwYQeYco=";
    };
  };
}
