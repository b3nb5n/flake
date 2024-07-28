{ config, lib, ... }: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = default_session;
      default_session = {
        command = "env AUTO_LOGIN=true $SHELL --login";
        user =
          lib.lists.findFirst (user: config.users.users.${user}.isNormalUser) ""
          (builtins.attrNames config.users.users);
      };
    };
  };
}
