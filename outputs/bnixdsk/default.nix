{ flakeInputs, pkgs, usrDrv, ... }@args: {
  nixosConfigurations.bnixdsk = flakeInputs.nixpkgs-unstable.lib.nixosSystem {
    inherit pkgs;
    inherit (pkgs) system;
    specialArgs = args;
    modules = [
      ./system.nix
      ./shared.nix

      ../../modules/nixos/amd-gpu.nix
      ../../modules/nixos/bluetooth.nix
      ../../modules/nixos/efi-boot.nix
      ../../modules/nixos/firewall.nix
      ../../modules/nixos/network-manager.nix
      ../../modules/nixos/portals.nix
      ../../modules/nixos/sound.nix
      ../../modules/nixos/steam.nix

      { networking.hostName = "bnixdsk"; }
    ];
  };

  homeConfigurations = {
    "ben@bnixdsk" = flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [
        ./home.nix
        ./shared.nix

        ../../modules/hm/environments/hyprland
        ../../modules/hm/features
        ../../modules/hm/local

        ({ pkgs, ... }: {
          home = {
            username = "ben";
            packages = with pkgs; [
              usrDrv.dev-env
              blueberry
              hyprpicker
              inkscape
              cinnamon.nemo
              lmms
              playerctl
              pulseaudio # do I actually need this here?
              qalculate-gtk
              spotify
              scarab
              nvtop
            ];
          };
        })
      ];
    };
  };
}
