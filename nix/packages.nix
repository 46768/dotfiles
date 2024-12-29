{ config, pkgs, ... }:

{
# The home.packages option allows you to install Nix packages into your
# environment.
	home.packages = [
		pkgs.fastfetch
			pkgs.firefox

			# Java
			pkgs.graalvm-ce
			pkgs.maven
	];
}
