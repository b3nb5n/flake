{ pkgs, config, lib, ... }: {
  imports = [
    ./shared.nix
    ../../modules/hm/features/alacritty.nix
    ../../modules/hm/features/direnv.nix
    ../../modules/hm/features/discord.nix
    ../../modules/hm/features/firefox.nix
    ../../modules/hm/features/git.nix
    ../../modules/hm/features/neofetch.nix
    ../../modules/hm/features/neovim.nix
    ../../modules/hm/features/zsh.nix
  ];

  home = rec {
    stateVersion = "23.05";
    username = "ben";
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [ rectangle spotify thunderbird-bin ];

    activation = {
      copyApplications = let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        baseDir="$HOME/Applications"
        if [ -d "$baseDir" ]; then
          rm -rf "$baseDir"
        fi
        mkdir -p "$baseDir"
        for appFile in ${apps}/Applications/*; do
          target="$baseDir/$(basename "$appFile")"
          $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
          $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
        done
      '';
    };
  };

  programs = { home-manager.enable = true; };
}
