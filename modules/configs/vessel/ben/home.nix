{ inputs, self, ... }: {
  flake.homeConfigurations."ben@vessel" =
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit (self.nixosConfigurations.vessel) pkgs;
      extraSpecialArgs = { hostName = "vessel"; };
      modules = (builtins.attrValues self.homeModules) ++ [
        ({ pkgs, ... }: {
          home = {
            username = "ben";
            stateVersion = "25.05";

            packages = with pkgs; [
              eza
              fd
              ripgrep
              fzf
              jq
              procs
              zip
              unzip
              stable.termscp
              systemctl-tui
              hyperfine
              wiki-tui
              ttyper
              tokei
              wiremix
              ffmpeg

              gnome-calculator
              gnome-calendar
              gnome-maps
              gnome-weather
              helvum
              blueberry
              inkscape
              blender
              discord
              nicotine-plus
              mullvad-vpn
              picard
              vlc
              obsidian

              olympus
              prismlauncher
            ];
          };

          modules = {
            alacritty.enable = true;
            btop.enable = true;
            direnv.enable = true;
            fastfetch.enable = true;
            firefox.enable = true;
            floorp.enable = true;
            fonts.enable = true;
            git.enable = true;
            gtk.enable = true;
            mako.enable = true;
            mpd.enable = true;
            neovim.enable = true;
            niri.enable = true;
            spotify.enable = true;
            ssh.enable = true;
            swayidle.enable = true;
            udiskie.enable = true;
            walker.enable = true;
            yazi.enable = true;
            zsh.enable = true;
          };
        })
      ];
    };
}
