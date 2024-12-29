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

sudo nixos-rebuild switch --flake /etc/nixos
sudo passwd yrth
su yrth

# Home manager configuration
if ! command -v git >/dev/null 2>&1; then
	echo "git not found"
	exit 1
fi

if [ -d ~/dotfiles ]; then
	rm -rf ~/dotfiles
fi

mkdir ~/dotfiles
git clone "https://github.com/46768/nvim-conf.git" ~/dotfiles/nvim
git clone "https://github.com/46768/hyprland-conf.git" ~/dotfiles/hyprland

if [ ! -d ~/.config/home-manager ]; then
	mkdir ~/.config/home-manager
fi
cp ./home.nix ~/.config/home-manager
cp ./flake.nix ~/.config/home-manager
cp ./flake.lock ~/.config/home-manager
home-manager switch --impure --flake ~/.config/home-manager
