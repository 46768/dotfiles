{ config, pkgs, ... }:

{
	home.packages = [
		pkgs.conda
		pkgs.sphinx
	];
}
