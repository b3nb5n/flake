{ pkgs, ... }: {
  nix = {
    useDaemon = true;
    configureBuildUsers = true;
    gc.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "@admin" ];
      extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    };
  };

  services.nix-daemon.enable = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  time.timeZone = "America/Phoenix";
  networking = rec {
    computerName = "bmacbook";
    hostName = computerName;
    dns = [ "1.1.1.1" ];
  };

  users.users = {
    ben = {
      home = "/Users/ben";
      createHome = false;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticWindowAnimationsEnabled = false;
      NSDisableAutomaticTermination = true;
      NSDocumentSaveNewDocumentsToCloud = false;
      # "com.apple.swipescrolldirection" = false;
    };
    dock = {
      autohide = true;
      launchanim = false;
      mru-spaces = false;
      show-recents = false;
      wvous-tr-corner = 12; # notification center
      orientation = "left";
      persistent-apps = [ ];
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "icnv";
      ShowPathbar = true;
    };
  };

  programs.zsh.enable = true;

  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';
}
