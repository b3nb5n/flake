{ pkgs, ... }: {
  home.packages = with pkgs; [ neofetch ];

  programs.zsh.initExtra = "neofetch";
}
