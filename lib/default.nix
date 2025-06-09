flakeInputs:

let
  isolated = import ./isolated;
  systems = import ./system flakeInputs;
in

systems // { inherit isolated; }
