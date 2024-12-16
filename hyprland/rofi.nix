{ config, pkgs, ... }:

{
	programs.rofi = {
		enable = true;
		location = "left";
	};
}
