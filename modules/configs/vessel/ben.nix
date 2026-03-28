{ self, ... }: {
  flake = {
    keys.vessel.ben = rec {
      default = [ ed25519 ];
      ed25519 =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQ56ik4/z/tsc/BTMRiRUzW38dbNePTKGPp6O4l4Ro9";
    };

    nixosConfigurationArgs.vessel.modules = [
      ({ config, ... }: {
        users.users.ben = {
          isNormalUser = true;
          extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
          hashedPasswordFile = config.age.secrets.password-ben.path;
          openssh.authorizedKeys.keys = with self.keys;
            external.shade.default ++ external.nail.default
            ++ external.e85064.default;
        };
      })
    ];

    homeConfigurationArgs."ben@vessel" = {
      modules = (builtins.attrValues self.homeModules) ++ [
        ({ pkgs, ... }: {
          home = {
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
  };
}
