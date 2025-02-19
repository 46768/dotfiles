# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

  # Enable broadcom sta
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "broadcom-sta"
  ];

# Enable nix flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Use Hyprland's Cachix
nix.settings = {
	substituters = [ "https://hyprland.cachix.org" ];
	trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
};

# Use the GRUB boot loader.
	boot.loader.grub.enable = true;
	boot.loader.grub.efiSupport = true;
	boot.loader.grub.device = "nodev";
	boot.loader.grub.configurationName = "Linux Boot Manager";
	boot.loader.grub.extraEntries = ''
		# Shutdown option
		menuentry "Shutdown" {
			halt
		}

		# Boot to firmware
		menuentry "Firmware" {
			fwsetup
		}
	'';
	boot.loader.efi.canTouchEfiVariables = true;
	boot.supportedFilesystems = [ "ntfs" ];
	boot.extraModulePackages = with config.boot.kernelPackages; [
		rtl88xxau-aircrack
	];

	networking.hostName = "pnixos";
	networking.networkmanager.enable = true;

	time.timeZone = "Asia/Bangkok";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
	"en_US.UTF-8/UTF-8"
	"th_TH.UTF-8/UTF-8"
  ];
  i18n.inputMethod = {
	enabled = "fcitx5";
	fcitx5.addons = [ pkgs.fcitx5-table-other ];
  };

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us,th";

services.displayManager.sddm.enable = true;
services.displayManager.sddm.wayland.enable = true;

# Enable CUPS to print documents.
# services.printing.enable = true;

# Enable sound.
# hardware.pulseaudio.enable = true;
# OR
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

# Enable printing
services.printing.enable = true;

# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;

# Virtualisation
	virtualisation.libvirtd.enable = true;
	virtualisation.docker.rootless = {
		enable = true;
		setSocketVariable = true;
	};
	programs.virt-manager.enable = true;

	environment.systemPackages = with pkgs; [
			home-manager
			git

# Util
			unzip

# Print driver
			cups
			hplip

# C stuff
			glibc
			gnumake
			gcc
			gdb

			# Python 3
			python3

			# Cron
			cron
	];

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		stdenv.cc.cc
	];

# Hyprland Window Manager
	programs.hyprland = {
		enable = true;

		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};

	fonts.packages = with pkgs; [
		nerd-fonts.fira-code
		sarabun-font
	];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
	services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
	system.stateVersion = "24.05"; # Did you read the comment?

}

