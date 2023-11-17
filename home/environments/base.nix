{ pkgs, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
  
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };
}