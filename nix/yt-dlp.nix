{ config, pkgs, ... }:

{
	programs.yt-dlp = {
		enable = true;
		settings = {
			downloader = "curl";
			progress = true;
			output = "~/yt-download/%(title)s.%(ext)s";
			concurrent-fragments = 4;
		};
	};
}
