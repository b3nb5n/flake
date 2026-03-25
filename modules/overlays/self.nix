{ self, ... }: {
  flake.overlays.self = final: _prev: {
    self = self.packages.${final.stdenv.hostPlatform.system};
  };
}
