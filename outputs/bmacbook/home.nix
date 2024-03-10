{ pkgs, config, ... }: {
  imports = [
    ./shared.nix
    ../../modules/hm/features/alacritty.nix
    ../../modules/hm/features/direnv.nix
    ../../modules/hm/features/discord.nix
    # ../../modules/hm/features/firefox.nix
    ../../modules/hm/features/git.nix
    ../../modules/hm/features/neofetch.nix
    ../../modules/hm/features/neovim.nix
    ../../modules/hm/features/vscode.nix
    ../../modules/hm/features/zsh.nix
  ];

  home = rec {
    stateVersion = "23.05";
    username = "ben";
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
	  rectangle
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
