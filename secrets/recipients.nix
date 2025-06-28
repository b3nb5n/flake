let
  permissionEntry = secret: {
    name = builtins.toString secret.path;
    value = secret.recipients;
  };

  secrets = import ./secrets.nix;
  entries = builtins.map permissionEntry secrets;
in builtins.listToAttrs entries
