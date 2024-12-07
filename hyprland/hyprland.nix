{ config, pkgs, ... }:

{
	imports = [ ../kitty/kitty.nix ];

	home.file = {
		".config/hypr/main.conf" = {
			source = ./hyprmain.conf;
			target = ".config/hypr/hyprmain.conf";
		};
	};

	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"source" = "~/.config/hypr/hyprmain.conf";
		};
	};
}
