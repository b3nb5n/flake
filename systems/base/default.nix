{ ... }: {
  system.stateVersion = "23.05";

  nix = {
    optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}