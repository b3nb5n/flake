
{ pkgs, config, ... }: {
  system.stateVersion = "23.05";

  imports = [
    ./hardware.nix
  ];

  nix = {
    optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "amdgpu" ];
  };

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";
  
  networking = {
    hostName = config.custom.system.name;
    networkmanager.enable = true;
    firewall.enable = true;
  };

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
  ];

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware = {
    opengl.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.ControllerMode = "bredr";
    };
  }; 

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
    ];
  };
}
