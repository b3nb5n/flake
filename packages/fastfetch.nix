{ flakeInputs, fastfetch, symlinkJoin, makeWrapper, ... }:

symlinkJoin {
  name = "fastfetch";
  paths = [ fastfetch ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/fastfetch \
      --add-flags "--config ${flakeInputs.self.dotfiles.fastfetch}/.config/fastfetch/config.jsonc" \
  '';
}

