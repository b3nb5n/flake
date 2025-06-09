{ ... }: {
  system.stateVersion = "25.05";

  hardware = {
    cpu.amd.updateMicrocode = true;
  };

  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
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

  # swapDevices =
  #   [{ device = "/dev/disk/by-uuid/bf92fa69-ac46-414d-afc5-b97ea57c088b"; }];

  # age.secrets.password-ben.file =
  #   pkgs.usrLib.flakeRoot "secrets/users/ben/password.age";


  # age.secrets.rootPassword.file =
  #   pkgs.usrLib.flakeRoot
  #     "/secrets/hosts/${config.networking.hostName}/root_password.age";

  # users.root.hashedPasswordFile =
  #   config.age.secrets.rootPassword.path;

  users.users = {
    root.password = "password";
    ben = {
      extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
      password = "password";
      # hashedPasswordFile = config.age.secrets.password-ben.path;
      # openssh.authorizedKeys.keys =
      #   let keys = import (pkgs.usrLib.flakeRoot "secrets/keys.nix");
      #   in [
      #     keys.users.ben
      #     # keys.users.e85064
      #   ];
    };
  };

  modules = {
    age.enable = true;
    bluetooth.enable = true;
    gpu-amd.enable = true;
    ly.enable = true;
    openrgb.enable = true;
    pipewire.enable = true;
    ssh.enable = true;
  };

  hardware.steam-hardware.enable = true;
  programs.steam.enable = true;
}
