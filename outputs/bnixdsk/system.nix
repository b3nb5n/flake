{ flakeInputs, pkgs, ... }: {
  imports = with flakeInputs.self.nixosModules; [
    ./hardware.nix

    gpu-amd
    bluetooth
    efi-boot
    firewall
    greetd
    network-manager
    portals
    sound
    steam
    ssh
    rgb
  ];

  system.stateVersion = "23.05";
  networking.hostName = "bnixdsk";

  users.users.ben = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
  };
}
