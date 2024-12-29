{ config, pkgs, ... }:

{
	xdg.configFile = {
		"nvim" = {
			source = ${config.home.homeDirectory}/dotfiles/nvim;
			target = "nvim";
		};
	};
	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
	};
}
