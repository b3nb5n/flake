{ pkgs, ... }: {
  imports = [
    ../base
    ./hardware.nix
  ];

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.ben = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    curl
    git
    zip
    unzip
    htop
    tree
    jq
  ];

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
}

