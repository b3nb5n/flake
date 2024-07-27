{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ../../modules/nixos/gpu-amd.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/efi-boot.nix
    ../../modules/nixos/firewall.nix
    ../../modules/nixos/greetd.nix
    ../../modules/nixos/network-manager.nix
    ../../modules/nixos/portals.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/rgb.nix
  ];

  system.stateVersion = "23.05";
  networking.hostName = "bnixdsk";

  users.users.ben = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
  };
}
