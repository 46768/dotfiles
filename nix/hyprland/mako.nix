{ config, pkgs, ... }:

{
	home.packages = [
		pkgs.mako
		pkgs.libnotify
	];

	xdg.configFile = {
		"mako/config" = {
			source = "${config.xdg.configHome}/home-manager/hyprland/mako/config";
			target = "mako/config";
		};
	};
}
