{ config, pkgs, ... }:

{
# The home.packages option allows you to install Nix packages into your
# environment.
	home.packages = [
		pkgs.fastfetch
			pkgs.kdePackages.dolphin

			# Utilities
			pkgs.brightnessctl
			pkgs.w3m

			# Media processing
			pkgs.ffmpeg

			# Android Dev
			pkgs.android-tools
			pkgs.android-studio

			# Node js 23
			pkgs.nodejs_23

			# Java
			pkgs.graalvm-ce
			pkgs.maven

			# C
			pkgs.cmake
			pkgs.clang-tools
			pkgs.valgrind
			pkgs.doxygen
			pkgs.meson
			pkgs.ninja

			# Profiling
			pkgs.linuxPackages_latest.perf

			# USB Utilities
			pkgs.usbutils

			# Gaming
			pkgs.prismlauncher
			pkgs.obs-studio

			# Game Dev
			pkgs.godot_4
			pkgs.gimp
			pkgs.krita

			# Python
			pkgs.conda
			pkgs.sphinx
			pkgs.manim
	];

	programs.librewolf = {
		enable = true;

		settings = {
			"privacy.resistFingerprinting.letterboxing" = true;
		};

		policies = {
			DisableTelemetry = true;
		};
	};

	programs.btop = {
		enable = true;
	};

	programs.git = {
		enable = true;
		userName = "46768";
		userEmail = "46768@bodin.ac.th";

		extraConfig = {
			init.defaultBranch = "main";
			credential.helper = "store";
		};
	};

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
	};

	programs.yt-dlp = {
		enable = true;
		settings = {
			downloader = "aria2c";
			progress = true;
			output = "~/yt-download/%(title)s.%(ext)s";
			concurrent-fragments = 4;
		};
	};
}
