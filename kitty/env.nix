{ config, pkgs, ... }:

{
	programs.kitty.environment = {
		"EDITOR" = "nvim";
	};
}
