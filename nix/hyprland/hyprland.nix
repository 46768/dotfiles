{ config, pkgs, ... }:

{
	imports = [
		../kitty/kitty.nix
			./hyprpaper.nix
			./hyprlock.nix
			./waybar.nix
			./rofi.nix
	];

	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"source" = "${config.home.homeDirectory}/dotfiles/hyprland/hyprmain.conf";
		};
	};
}
