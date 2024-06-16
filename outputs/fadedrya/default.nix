{ flakeInputs, pkgs, repos, ... }@args: {
  homeConfigurations = {
    "ben@fadedrya" = flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [
        ./home.nix
        ./shared.nix

        ../../modules/hm/environments/media-console
        ../../modules/hm/features/direnv.nix
        ../../modules/hm/features/git.nix
        ../../modules/hm/features/neovim.nix
        ../../modules/hm/features/zsh.nix
        ../../modules/hm/features/alacritty.nix
        ../../modules/hm/features/firefox.nix

        ({ pkgs, ... }: {
          home = {
            username = "ben";
            packages = [ repos.usrDrv.dev-env ];
          };
        })
      ];
    };
  };
}
