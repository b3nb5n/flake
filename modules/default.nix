args: let
  options = import ./options.nix args;
in {
  shared = {
    system = import ./shared/system args;
    theme = import ./shared/theme args;
  };

  hm = {
    options = options.hm;

    user = import ./hm/user args;
  };

  nixos = {
    options = options.nixos;
  };
}