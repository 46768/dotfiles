{ config, pkgs, ... }:

{
	home.packages = [
		pkgs.conda
	];
}
