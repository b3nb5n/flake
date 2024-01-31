{ registries, ... }: {
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    package = registries.nixpkgsUnstable.steam;
  };
}
