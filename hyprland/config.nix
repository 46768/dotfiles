{ config, pkgs, ... }:

{
	home.file = {
		".config/hypr/main.conf" = {
			source = ./hyprmain.conf;
			target = ".config/hypr/hyprmain.conf";
		};

		".config/hypr/background" = {
			source = ./background;
			recursive = true;
			target = ".config/hypr/background";
		};

		".config/hypr/waybar" = {
			source = ./waybar;
			recursive = true;
			target = ".config/hypr/waybar";
		};
	};
}
