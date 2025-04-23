{
	description = "NixOS Flake Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { self, nixpkgs, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs_config = {
			allowUnfree = true;
		};
		pkgs = import nixpkgs { system = system; config = pkgs_config; };
	in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; pkgs = pkgs; };
			system = system;
			modules = [
				./system.nix
			];
		};

		nixosConfigurations.live = nixpkgs.lib.nixosSystem {
			system = system;
			modules = [
				(nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
			];
		};
	};
}
