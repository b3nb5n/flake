{ inputs, self, ... }: {
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = builtins.attrValues self.overlays;
      config.allowUnfree = true;
    };
  };
}
