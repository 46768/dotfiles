{ config, pkgs, ... }:

{
	home.file = {
		".config/nvim" = {
			source = ./nvim;
			recursive = true;
			target = ".config/nvim";
		};
	};
	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
	};
}
