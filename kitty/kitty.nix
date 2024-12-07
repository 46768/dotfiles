{ config, pkgs, ... }:

{
	imports = [
		./env.nix
			./bash.nix
	];
	programs.kitty = {
		enable = true;
		shellIntegration.enableBashIntegration = true;
		settings = {
			confirm_os_window_close = 0;
			dynamic_background_opacity = true;
			background_opacity = "0.5";
			background_blur = 5;
		};
	};
}
