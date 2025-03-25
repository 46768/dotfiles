{ config, pkgs, ... }:

{
# The home.packages option allows you to install Nix packages into your
# environment.
	home.packages = [
		pkgs.fastfetch
			pkgs.kdePackages.dolphin

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
			pkgs.cmocka
			pkgs.scons

			# GNU Plot
			pkgs.gnuplot

			# Profiling
			pkgs.linuxPackages_latest.perf

			# USB Utilities
			pkgs.usbutils

			# Gaming
			pkgs.prismlauncher
			pkgs.obs-studio

			# Game dev
			pkgs.godot_4
			pkgs.gimp
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
}
