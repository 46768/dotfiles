{ config, pkgs, ... }:

# Import modules
{
	imports = [
		./hyprland/hyprland.nix
			./neovim.nix
			./git.nix
			./packages.nix
			./btop.nix
			./python.nix
	];
}
