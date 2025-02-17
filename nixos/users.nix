{ config, lib, pkgs, inputs, ... }:

{
	users.users.yrth = {
		isNormalUser = true;
		home = "/home/yrth";
		description = "My User!";
		extraGroups = [
			"wheel"
			"networkmanager"
			"libvirtd"
			"docker"
		];
	};
}
