{
	description = "NixOS Flake Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = inputs@{ self, nixpkgs, ... }: {
		nixosConfigurations.pnixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./system.nix
				./users.nix
			];
		};
	};
}
