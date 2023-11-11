{ vscodeExtensions, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with vscodeExtensions.vscode-marketplace; [
      jnoortheen.nix-ide
      naumovs.color-highlight
    ];
  };
}