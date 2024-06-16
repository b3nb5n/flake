{ repos, ... }: {
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    package = repos.nixpkgsUnstable.steam;
  };
}
