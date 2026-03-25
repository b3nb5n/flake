{ lib, ... }: {
	options.flake.lib = lib.mkOption {
		type = lib.types.lazyAttrsOf lib.types.anything;
		default =	{};
	};
}
