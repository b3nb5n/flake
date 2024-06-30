{ ... }: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = default_session;
      default_session = {
        command = "env AUTO_LOGIN=true $SHELL";
        user = "ben";
      };
    };
  };
}
