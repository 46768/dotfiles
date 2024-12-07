{
	description = "Home Manager configuration of yrth";

	inputs = {
# Specify the source of Home Manager and Nixpkgs.
		nixos-flake.url = "path:/etc/nixos";
		nixpkgs.follows = "nixos-flake/nixpkgs";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
		let
		system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
	in {
		homeConfigurations."yrth" = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;

# Specify your home configuration modules here, for example,
# the path to your home.nix.
			modules = [
				./home.nix
			];

# Optionally use extraSpecialArgs
# to pass through arguments to home.nix
		};
	};
}
