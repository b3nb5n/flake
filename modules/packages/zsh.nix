{ self, ... }: {
  perSystem = { pkgs, ... }: {
    packages.zsh = pkgs.symlinkJoin {
      name = "zsh";
      paths = with pkgs; [ zsh ];
      buildInputs = with pkgs; [ makeWrapper ];
      passthru.shellPath = "/bin/zsh";

      postBuild = ''
        wrapProgram $out/bin/zsh \
          --set ZDOTDIR "${self.dotfiles.zsh}"
      '';
    };
  };
}
