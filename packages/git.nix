{ flakeInputs, git, symlinkJoin, makeWrapper, ... }:

let configDir = "${flakeInputs.self.dotfiles.git}/.config/git";
in symlinkJoin {
  name = "git";
  paths = [ git ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/git \
      --set GIT_CONFIG_SYSTEM "${configDir}/config" \
      --add-flags "-c core.excludesFile=\"${configDir}/ignore\""
  '';
}

