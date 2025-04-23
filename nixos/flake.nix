{
	description = "NixOS Flake Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { self, nixpkgs, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations.nixos = pkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			system = system;
			modules = [
				./system.nix
			];
		};

		nixosConfigurations.live = pkgs.lib.nixosSystem {
			system = system;
			modules = [
				(nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
			];
		};
	};
}
