{ ... }: {
  programs.git = {
    enable = true;
    userName = "ben";
    userEmail = "benbaldwin000@gmail.com";
    extraConfig = {
      http = {
        postBuffer = 524288000;
      };
    };
  };
}