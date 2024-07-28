{ pkgs, ... }: {
  imports = [ ./common.nix ];

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    zsh.enable = true;
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [ vim git ];
}
