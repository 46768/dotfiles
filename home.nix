{ config, pkgs, ... }:

# You mostly never want to change this file as it manages the nix modules
# for this user
{
# Home Manager needs a bit of information about you and the paths it should
# manage.
	home.username = "yrth";
	home.homeDirectory = "/home/yrth";

	imports = [
		./nix/imports.nix
	];

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
	home.stateVersion = "24.05"; # Please read the comment before changing.

# Enable XDG
		xdg.enable = true;

# Import nix modules
	xdg.configFile."home-manager/nix" = {
		source = "${config.home.homeDirectory}/home-manager/nix";
		target = "home-manager/nix";
	};

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
