_flakeInputs: {
  keys = import ./keys.nix;
  secrets = import ./secrets.nix;

  getSecrets = keys:
    let
      contains = list: target: builtins.any (el: el == target) list;
      isRecipient = secret: builtins.any (contains keys) secret.recipients;

      secrets = import ./secrets.nix;
    in builtins.filter isRecipient secrets;
}
