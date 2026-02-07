{ flakeInputs, pkgs, config, ... }: {
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
      root.hashedPasswordFile = config.age.secrets.password.path;
      ben = {
        extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
        hashedPasswordFile = config.age.secrets."ben.password".path;
        openssh.authorizedKeys.keys = with flakeInputs.self.secrets.keys;
          external.shade.all ++ external.nail.all ++ external.e85064.all;
      };
    };
  };

  networking = {
    firewall.allowedTCPPorts = [ 8081 ];
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
}
