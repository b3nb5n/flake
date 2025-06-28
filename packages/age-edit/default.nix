{ lib, stdenv, makeWrapper, age, jq, ... }:

stdenv.mkDerivation {
	name = "age-edit";
	src = ./.;

	buildInputs = [ makeWrapper ];
	installPhase = ''
		mkdir -p $out/bin
		cp age-edit.sh $out/bin/age-edit

		wrapProgram $out/bin/age-edit \
			--suffix PATH ':' ${lib.makeBinPath [ age jq ]}
	'';
}
