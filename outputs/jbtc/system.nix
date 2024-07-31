{ flakeInputs, pkgs, config, ... }: {
  imports = with flakeInputs.self.nixosModules; [
    ./hardware.nix

    gpu-nvidia
    bluetooth
    efi-boot
    firewall
    greetd
    network-manager
    portals
    sound
    ssh
  ];

  system.stateVersion = "24.05";
  networking.hostName = "jbtc";

  users.users = rec {
    ben = jb;
    jb = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    };
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;
  hardware.nvidia.package = config.boot.kernelPackages.nvidia_x11_legacy470;
}
