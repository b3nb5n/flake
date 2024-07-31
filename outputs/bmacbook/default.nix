flakeInputs: {
  darwinConfigurations.bmacbook = flakeInputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [ ./shared.nix ./system.nix ];
    specialArgs = { inherit flakeInputs; };
  };

  homeConfigurations."ben@bmacbook" =
    flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit (flakeInputs.self.darwinConfigurations.bmacbook) pkgs;
      modules = [ ./shared.nix ./home.nix ];
      extraSpecialArgs = { inherit flakeInputs; };
    };
}
