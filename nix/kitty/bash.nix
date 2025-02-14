{ config, pkgs, ... }:

let
	homeDir = config.home.homeDirectory;
	configDir = config.xdg.configHome;
in
{
	programs.bash = {
		enable = true;
		initExtra = ''
			fastfetch
		'';
		shellAliases = {
			"sys-rebuild" = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
			"valgrind-f" = "valgrind --leak-check=full --track-origins=yes -s";
			"vinote" = "NVIM_APPNAME=nvim-notes nvim";
			"panic" = "echo 'pls no shutdown'";
		};
	};

	# Bash scripts
	home.packages = [
		# Sample script
		(pkgs.writeShellScriptBin "my-hello" ''
echo "Hello, ${config.home.username}!"
echo "My home dir is ${homeDir}"
		 '')

		# Home rebuild script
		(pkgs.writeShellScriptBin "home-rebuild" ''
if ! command -v git >/dev/null 2>&1; then
	echo "git not found"
	exit 1
fi

git -C ${configDir}/nvim pull

curGen=$(home-manager generations | head -n 1 | grep -o -E "id [0-9]+" | grep -o -E "[0-9]+")
nextGen=$((curGen + 1))

git -C ${configDir}/home-manager add .
git -C ${configDir}/home-manager commit -m "Generation $nextGen $(date)"

home-manager switch --impure --flake ${configDir}/home-manager
		 '')

		# System sync script
		(pkgs.writeShellScriptBin "sys-sync" ''
if ! command -v git >/dev/null 2>&1; then
	echo "git not found"
	exit 1
fi

curGen=$(readlink "$(readlink ${homeDir}/.nix-profile)" | grep -oP "\d*")

sudo rm -r $(ls -d ${configDir}/home-manager/nixos/*)
sudo cp -r /etc/nixos/* ${configDir}/home-manager/nixos
sudo rm $(ls -d ${configDir}/home-manager/nixos/* | grep -i ".*\.backup")
sudo rm $(ls -d ${configDir}/home-manager/nixos/* | grep -i ".*/hardware-configuration.nix")

git -C ${configDir}/home-manager add .
git -C ${configDir}/home-manager commit -m "System sync gen $curGen $(date)"
		 '')
	];
}
