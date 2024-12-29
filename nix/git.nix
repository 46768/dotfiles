{ config, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userName = "46768";
		userEmail = "46768@bodin.ac.th";

		extraConfig = {
			init.defaultBranch = "main";
		};

		includes = [
		{
			contents = {
				credential.helper = "store";
			};
		}
		];
	};
}
