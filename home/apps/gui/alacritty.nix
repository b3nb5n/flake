{ pkgsUnstable, ... }: {
  programs.alacritty = {
    enable = true;
    package = pkgsUnstable.alacritty;
  };
}