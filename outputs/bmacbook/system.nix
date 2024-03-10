{ pkgs, ... }: {
  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    useDaemon = true;
    configureBuildUsers = true;
    settings = { 
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "@admin" ];
      extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    };
  };

  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';

  imports = [
    ./shared.nix
  ];

  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
  ];
}
