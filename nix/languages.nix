{ config, pkgs, ... }:

{
	programs.fcitx5 = {
		enable = true;
		addons = [ pkgs.fcitx5-table-other ];
	};

	home.sessionVariables = {
		GTK_IM_MODULE = "fcitx";
		QT_IM_MODULE = "fcitx";
		XMODIFIERS = "@im-fcitx";
	};
}
