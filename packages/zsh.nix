{ flakeInputs, zsh, symlinkJoin, makeWrapper, ... }:

symlinkJoin {
  name = "zsh";
  paths = [ zsh ];
  buildInputs = [ makeWrapper ];
  passthru.shellPath = "/bin/zsh";

  postBuild = ''
    wrapProgram $out/bin/zsh \
      --set ZDOTDIR "${flakeInputs.self.dotfiles.zsh}"
  '';
}
