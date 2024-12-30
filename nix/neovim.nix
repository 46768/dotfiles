{ config, pkgs, ... }:

{
	xdg.configFile = {
		"nvim" = {
			source = "${config.home.homeDirectory}/dotfiles/nvim/nvim";
			recursive = true;
			target = "nvim";
		};
	};
	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
	};
}
