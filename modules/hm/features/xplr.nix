{ pkgs, ... }: {
  programs.xplr = {
    enable = true;
    extraConfig = builtins.readFile ./xplr.lua;
    plugins = {
      wl-clipboard = pkgs.fetchFromGitHub {
        owner = "sayanarijit";
        repo = "wl-clipboard.xplr";
        rev = "main";
        sha256 = "I4rh5Zks9hiXozBiPDuRdHwW5I7ppzEpQNtirY0Lcks=";
      };
      tree-view = pkgs.fetchFromGitHub {
        owner = "sayanarijit";
        repo = "tree-view.xplr";
        rev = "main";
        sha256 = "v9KDupi5l3F+Oa5X6pc/Qz9EhaFIrnQK5sckjne/kIU=";
      };
    };
  };
}
