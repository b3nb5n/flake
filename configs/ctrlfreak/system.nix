{ flakeInputs, pkgs, ... }: {
  imports = with flakeInputs.self.nixosModules; [
    ./hardware.nix

    gpu-amd
    efi-boot
    firewall
    network-manager
    portals
    sound
    steam
    ssh
    adblock
    minecraft
  ];

  system.stateVersion = "23.05";
  networking.hostName = "ctrlfreak";
  programs.hyprland.enable = true;

  users.users = rec {
    nathan = ben;
    tv = ben;
    ben = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "video" "audio" "networkmanager" "minecraft" ];
    };
  };
}
