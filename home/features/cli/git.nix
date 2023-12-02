{ config, ... }: {
  programs.git = {
    enable = true;
    userName = config.custom.user.name;
    userEmail = config.custom.user.email;
    extraConfig = {
      http = {
        postBuffer = 524288000;
      };
    };
  };
}