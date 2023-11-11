
{ confg, pkgs, ... }: {
  system.stateVersion = "23.05";
  
  imports = [ ./hardware.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bnixdsk";
  networking.networkmanager.enable = true;

  nix = {
    optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    curl
    git
    killall
  ];

  users.users.ben = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  hardware = {
    opengl.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
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

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk 
      xdg-desktop-portal-hyprland
    ];
  };
}
