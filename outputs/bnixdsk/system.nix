{ pkgs, ... }: {
  imports = [
    ./shared.nix
    ./hardware.nix
    ../../modules/nixos/amd-gpu.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/efi-boot.nix
    ../../modules/nixos/firewall.nix
    ../../modules/nixos/greetd.nix
    ../../modules/nixos/network-manager.nix
    ../../modules/nixos/portals.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/ssh.nix
  ];

  system.stateVersion = "23.05";
  networking.hostName = "bnixdsk";

  nix = {
    optimise.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.ben = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    curl
    git
    zip
    unzip
    tree
  ];

  programs.zsh.enable = true;
  programs.dconf.enable = true;
}
