{ flakeInputs, git, symlinkJoin, makeWrapper, ... }:

symlinkJoin {
  name = "git";
  paths = [ git ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/git \
      --set GIT_CONFIG_SYSTEM "${flakeInputs.self.dotfiles.git}/.config/git/config"
  '';
}

