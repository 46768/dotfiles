{ config, pkgs, ... }:

{
	services.hyprpaper = {
		enable = true;
		settings = {
			preload = "${config.home.homeDirectory}/dotfiles/hyprland/hyprland/background/bg1.png";
			wallpaper = ", ${config.home.homeDirectory}/dotfiles/hyprland/hyprland/background/bg1.png";
		};
	};
}
