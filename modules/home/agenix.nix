{ flakeInputs, pkgs, lib, config, hostName, ... }:
let cfg = config.modules.agenix;
in {
  options.modules.agenix.enable = lib.mkEnableOption "agenix";

  imports = [ flakeInputs.agenix.homeManagerModules.default ];

  config = lib.mkIf cfg.enable {
    age.secrets = let
      keys_ = flakeInputs.self.secrets.keys;
      keys = keys_.${hostName}.${config.home.username}.all or [ ];

      secrets_ = flakeInputs.self.secrets.secrets;
      isRecipient = secret: builtins.any
        (pkgs.self.lib.lists.contains keys)
        secret.recipients;

      secrets = builtins.filter isRecipient secrets_;

      secretConfigEntry = secret:
        let
          localHost = secret.host == hostName;
          hostPrefix = if localHost then "" else "${secret.host}.";

          localUser = localHost && secret.user == config.home.username;
          userPrefix = if localUser then "" else "${secret.user}.";

          secretName = pkgs.self.lib.fs.pathName secret.path;
        in {
          name = "${hostPrefix}${userPrefix}${secretName}";
          value.file = secret.path;
        };

      configEntries = builtins.map secretConfigEntry secrets;
    in builtins.listToAttrs configEntries;
  };
}
