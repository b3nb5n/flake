{ flakeInputs, pkgs, ... }: {
  imports = with flakeInputs.self.homeModules; [ eww hypr gtk local gui cli ];

  home = {
    stateVersion = "24.05";
    username = "jb";
    packages = with pkgs; [ ];
  };
}
