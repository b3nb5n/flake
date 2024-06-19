{ config, ... }: {
  programs.git = {
    enable = true;
    userName = config.home.username;
    userEmail = "benbaldwin000@gmail.com";
    extraConfig = {
      http = {
        postBuffer = 524288000;
      };
    };
  };

  programs.gh.enable = true;
}
