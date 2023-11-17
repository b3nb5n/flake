{ lib, ... }: {
  theme = import ./theme.nix { inherit lib; };
}