args: {
  hardware = import ./hardware args;
  theme = import ./theme.nix args;
  user = import ./user.nix args;
}