{ config, pkgs, ... }:

{
	imports = [
		../kitty/kitty.nix
			./hyprpaper.nix
			./hyprlock.nix
			./waybar.nix
			./rofi.nix
	];

	home.packages = [
		# Hyprland Clipboard
		pkgs.wl-clipboard
	];

	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"source" = "${config.home.homeDirectory}/dotfiles/hyprland/hyprland/hyprmain.conf";
		};
	};
}
