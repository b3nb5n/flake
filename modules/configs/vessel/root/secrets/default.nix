{ self, ... }: {
	flake.secrets.vessel.root = self.lib.secrets.importSecretsDir {
		path = ./.;
		defaultPublicKeys = self.keys.vessel.root.default;
	};
}
