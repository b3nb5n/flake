{ pkgs, const, ... }: {
  programs.home-manager.enable = true;
  home = {
    stateVersion = "23.05";
    username = const.user.name;
    homeDirectory = "/home/${const.user.name}";
  };
  
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };
}