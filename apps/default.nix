{ self, nixpkgs, ... }: 

let
	programs = system: {
		neovim = "${self.packages.${system}.neovim}/bin/nvim";
	};

	apps = system: 
		builtins.mapAttrs
			(_name: program: { inherit program; type = "app"; })
			(programs system);
in

builtins.listToAttrs
	(builtins.map
		(system: { name = system; value = apps system; })
		nixpkgs.lib.systems.flakeExposed)

