{ flakeInputs, pkgs, usrDrv, ... }@args: {
  homeConfigurations = {
    "ben@fadedrya" = flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [
        ../../modules/hm/features/direnv.nix
        ../../modules/hm/features/git.nix
        ../../modules/hm/features/neofetch.nix
        ../../modules/hm/features/neovim.nix
        ../../modules/hm/features/zsh.nix

        ({ pkgs, ... }: {
          home = {
            username = "ben";
            packages = with pkgs; [ usrDrv.dev-env nvtop ];
          };
        })
      ];
    };
  };
}
