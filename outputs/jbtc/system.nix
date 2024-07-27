{ pkgs, config, ... }: {
  imports = [
    ./shared.nix
    ./hardware.nix
    ../common/system.nix

    ../../modules/nixos/gpu-nvidia.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/efi-boot.nix
    ../../modules/nixos/firewall.nix
    # ../../modules/nixos/greetd.nix
    ../../modules/nixos/network-manager.nix
    ../../modules/nixos/portals.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/ssh.nix
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
