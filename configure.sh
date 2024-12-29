#!/usr/bin/env bash

echo "This will override any current configuration.nix and flake.nix in /etc/nixos"
echo "A backup should be made with the name configuration.nix.backup and flake.nix.backup"
read -p "Continue? (y/n): " confirm && [[ $confirm == [yY] ||  $confirm == [yY][eE][sS] ]] || exit 1

# System configuration
function createBackup () {
	if [ -f /etc/nixos/configuration.nix ]; then
		sudo cp $1 ${1}.backup
	fi
	if [ ! -f "${1}.backup" ] && [ -f $1 ]; then
		echo "Failed making backup for ${1}"
		exit 1
	fi
	sudo rm ${1}
	echo "Created backup for ${1}"
}

createBackup "/etc/nixos/configuration.nix"
createBackup "/etc/nixos/flake.nix"
createBackup "/etc/nixos/flake.lock"
createBackup "/etc/nixos/system.nix"
createBackup "/etc/nixos/users.nix"

sudo cp ./nixos/flake.nix /etc/nixos/flake.nix
sudo cp ./nixos/flake.lock /etc/nixos/flake.lock
sudo cp ./nixos/system.nix /etc/nixos/system.nix
sudo cp ./nixos/users.nix /etc/nixos/users.nix

sudo nixos-rebuild switch --flake /etc/nixos#nixos
sudo passwd yrth

# Home manager configuration
if ! command -v git >/dev/null 2>&1; then
	echo "git not found"
	exit 1
fi

if [ -d /home/yrth/dotfiles ]; then
	rm -rf /home/yrth/dotfiles
fi

sudo -u yrth mkdir /home/yrth/dotfiles
sudo -u yrth git clone "https://github.com/46768/nvim-conf.git" /home/yrth/dotfiles/nvim
sudo -u yrth git clone "https://github.com/46768/hyprland-conf.git" /home/yrth/dotfiles/hyprland

if [ ! -d /home/yrth/.config ]; then
	sudo -u yrth mkdir /home/yrth/.config
fi

if [ ! -d /home/yrth/.config/home-manager ]; then
	sudo -u yrth mkdir /home/yrth/.config/home-manager
fi
sudo -u yrth cp ./home.nix /home/yrth/.config/home-manager
sudo -u yrth cp ./flake.nix /home/yrth/.config/home-manager
sudo -u yrth cp ./flake.lock /home/yrth/.config/home-manager

# First switch to bootstrap modules
sudo -u yrth home-manager switch --impure --flake /home/yrth/.config/home-manager
# Second switch to actually install the module
sudo -u yrth home-manager switch --impure --flake /home/yrth/.config/home-manager
