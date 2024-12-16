{ config, pkgs, ... }:

{
	imports = [
	../kitty/kitty.nix
	./config.nix
	./hyprlock.nix
	./waybar.nix
	];

	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"source" = "./hyprmain.conf";
		};
	};

	services.hyprpaper = {
		enable = true;
		settings = {
			preload = "~/.config/hypr/background/bg1.png";
			wallpaper = ", ~/.config/hypr/background/bg1.png";
		};
	};
}
