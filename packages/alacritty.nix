{ flakeInputs, alacritty, nerd-fonts, symlinkJoin, makeWrapper, ... }:

symlinkJoin {
  name = "alacritty";
  paths = [ alacritty nerd-fonts.atkynson-mono ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/alacritty \
      --add-flags "--config-file ${flakeInputs.self.dotfiles.alacritty}/.config/alacritty.toml"
  '';
}
