{ pkgs, ... }: {
  imports = [ ./common.nix ];

  nix.optimise.automatic = true;

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    zsh.enable = true;
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [ vim git ];

  services.fstrim.enable = true;
}
