flakeInputs: final: prev:
# TODO: figure out why the package names need to be set explicitly here
{ inherit (flakeInputs.self.packages.${final.system}) neovim; }
