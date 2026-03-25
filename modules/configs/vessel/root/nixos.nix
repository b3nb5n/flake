{ inputs, self, ... }: {
  flake.nixosConfigurations.vessel = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = (builtins.attrValues self.nixosModules) ++ [
      ({ pkgs, config, ... }: {
        networking.hostName = "vessel";
        system.stateVersion = "25.05";

        hardware = {
          cpu.amd.updateMicrocode = true;
          steam-hardware.enable = true;
        };

        boot = {
          kernelModules = [ "kvm-amd" ];
          extraModulePackages = [ ];

          loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };

          initrd = {
            kernelModules = [ ];
            availableKernelModules =
              [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
          };
        };

        fileSystems = {
          "/" = {
            device = "/dev/disk/by-label/NIXOS";
            fsType = "ext4";
          };

          "/boot" = {
            device = "/dev/disk/by-label/BOOT";
            fsType = "vfat";
            options = [ "fmask=0077" "dmask=0077" ];
          };
        };

        users = {
          defaultUserShell = pkgs.zsh;

          users = {
            root = {
              hashedPasswordFile = config.age.secrets.password-root.path;
            };

            ben = {
              isNormalUser = true;
              extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
              hashedPasswordFile = config.age.secrets.password-ben.path;
              openssh.authorizedKeys.keys = with self.keys;
                external.shade.default ++ external.nail.default ++ external.e85064.default;
            };
          };
        };

        modules = {
          agenix.enable = true;
          bluetooth.enable = true;
          gpu-amd.enable = true;
          ly.enable = true;
          openrgb.enable = true;
          pipewire.enable = true;
          ssh.enable = true;
        };

        services = {
          mullvad-vpn.enable = true;
          udisks2.enable = true;
        };

        programs = {
          zsh.enable = true;
          hyprland.enable = true;
          niri.enable = true;
          steam.enable = true;
        };
      })
    ];
  };
}
