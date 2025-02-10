{ config, pkgs, ... }:

{
	services.hyprpaper = {
		enable = true;
		settings = {
			preload = "${config.xdg.configHome}/home-manager/hyprland/background/bg1.png";
			wallpaper = ", ${config.xdg.configHome}/home-manager/hyprland/background/bg1.png";
		};
	};
}
