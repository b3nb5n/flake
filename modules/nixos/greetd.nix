args: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = default_session;
      default_session = {
        command = "$SHELL";
        user = "ben";
      };
    };
  };
}
