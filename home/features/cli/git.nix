{ const, ... }: {
  programs.git = {
    enable = true;
    userName = const.user.name;
    userEmail = const.user.email;
    extraConfig = {
      http = {
        postBuffer = 524288000;
      };
    };
  };
}