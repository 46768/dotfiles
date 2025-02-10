{
	description = "NixOS Flake Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = inputs@{ self, nixpkgs, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			system = "x86_64-linux";
			modules = [
				./system.nix
				./users.nix
			];
		};
	};
}
