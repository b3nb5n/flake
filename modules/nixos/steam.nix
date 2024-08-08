{ pkgs, ... }: {
  hardware.steam-hardware.enable = true;
  programs.steam = {
    # package = pkgs.stable.steam;
    enable = true;
  };
}
