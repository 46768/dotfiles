{ config, pkgs, ... }:

{
# The home.packages option allows you to install Nix packages into your
# environment.
	home.packages = [
		pkgs.fastfetch
			pkgs.firefox
			pkgs.dolphin
			pkgs.firejail

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

			# GNU Plot
			pkgs.gnuplot

			# Profiling
			pkgs.linuxPackages_latest.perf

			# USB Utilities
			pkgs.usbutils

			# Gaming
			pkgs.prismlauncher
	];
}
