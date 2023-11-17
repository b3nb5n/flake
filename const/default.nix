args: {
  hardware = import ./hardware args;
  theme = import ./themes/treehouse.nix args;
  system = import ./system.nix args;
  user = import ./user.nix args;
}