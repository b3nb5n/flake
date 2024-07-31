{ flakeInputs, ... }: {
  imports = with flakeInputs.self.homeModules; [ cli ];

  home = {
    stateVersion = "23.05";
    username = "ben";
  };
}
