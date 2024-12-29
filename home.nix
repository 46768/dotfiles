{ config, pkgs, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
	home.username = "yrth";
	home.homeDirectory = "/home/yrth";

	imports = [
		./nix/hyprland/hyprland.nix
			./nix/neovim/neovim.nix
			./nix/git.nix
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

# The home.packages option allows you to install Nix packages into your
# environment.
	home.packages = [
		pkgs.fastfetch
			pkgs.firefox

			# Java
			pkgs.graalvm-ce
			pkgs.maven

# # You can also create simple shell scripts directly inside your
# # configuration. For example, this adds a command 'my-hello' to your
# # environment:
	(pkgs.writeShellScriptBin "my-hello" ''
		echo "Hello, ${config.home.username}!"
		echo "My home dir is ${config.home.homeDirectory}"
	'')
	];

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
