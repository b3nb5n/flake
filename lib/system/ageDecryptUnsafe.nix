{ pkgs, ... }:

identity: secret: 
let
	secretsRoot = ../../secrets;

	identityDirPath = /${secretsRoot}/${identity.host}/${identity.user}/unsafe;
  identityDir = builtins.readDir 
		(builtins.filterSource
			(path: type: type == "regular")
			identityDirPath);

	identityPaths = builtins.map
		(name: /${identityDirPath}/${name})
		(builtins.attrNames identityDir);

	identityArgs = pkgs.lib.concatStrings
		(builtins.map
			(path: "-i ${path}")
			identityPaths);

	secretPath = /${secretsRoot}/${secret.host}/${secret.user}/${secret.name}.age;

	drv = pkgs.stdenv.mkDerivation {
		name = "${secret.host}-${secret.user}-${secret.name}";
		src = secretPath;
		buildInputs = with pkgs; [ age ];
		phases = [ "installPhase" ];
		installPhase = "age --decrypt -o $out ${identityArgs} $src";
	};
in
builtins.readFile drv
