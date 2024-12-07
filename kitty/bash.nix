{ config, pkgs, ... }:

{
	programs.bash = {
		enable = true;
		shellAliases = {
			"sys-rebuild" = "sudo nixos-rebuild switch --flake /etc/nixos";
			"home-rebuild" = "home-manager switch --flake ~/.config/home-manager";
		};
	};
}
