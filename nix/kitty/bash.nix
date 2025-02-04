{ config, pkgs, ... }:

let
	homeDir = config.home.homeDirectory;
	configDir = config.xdg.configHome;
in
{
	programs.bash = {
		enable = true;
		shellAliases = {
			"sys-rebuild" = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
			"valgrind-f" = "valgrind --leak-check=full --track-origins=yes -s";
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

if [ ! -d ${homeDir}/dotfiles ]; then
	mkdir ${homeDir}/dotfiles
	git clone https://github.com/46768/nvim-conf.git ${homeDir}/dotfiles/nvim
	git clone https://github.com/46768/hyprland-conf.git ${homeDir}/dotfiles/hyprland
fi

git -C ${homeDir}/dotfiles/hyprland pull
git -C ${homeDir}/dotfiles/nvim pull

curGen=$(home-manager generations | head -n 1 | grep -o -E "id [0-9]+" | grep -o -E "[0-9]+")
nextGen=$((curGen + 1))

git -C ${configDir}/home-manager add .
git -C ${configDir}/home-manager commit -m "Generation $nextGen $(date)"

home-manager switch --impure --flake ~/.config/home-manager
		 '')
	];
}
