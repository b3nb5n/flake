{ ... }: {
	flake.keys.vessel.ben = rec {
		default =  ed25519;
		ed25519 = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQ56ik4/z/tsc/BTMRiRUzW38dbNePTKGPp6O4l4Ro9" ];
	};
}
