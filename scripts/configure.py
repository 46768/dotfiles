from pathlib import Path
import shutil
import subprocess

# Confirmation message
print("""
This script will override any current system config, and home manager
config. The user 'yrth' will be created and home manager config placed
there. A backup system config will be at /etc/nixos.backup

""")
confirmation = input("Continue? (y/n): ").lower()

while confirmation not in ["y", "n"]:
    confirmation = input("Please input either 'y' or 'n': ").lower()

if confirmation == "n":
    exit(0)

# System configs
system_config_source = Path("nixos")
system_config_path = Path("/etc/nixos")

# User configs
config_repo_url = "https://github.com/46768/dotfiles.git"
config_repo_path = Path("/home/yrth/.config/home-manager")

# Neovim configs
nvim_config_url = "https://github.com/46768/nvim-conf.git"
nvim_config_path = Path("/home/yrth/.config/nvim")


# Backup current config
system_config_backup = Path("/etc/nixos.backup")
shutil.copytree(system_config_path, system_config_backup)

# Delete current config
shutil.rmtree(system_config_path)

# Apply system config
hardware_config_path = system_config_backup / "hardware-configuration.nix"
shutil.copytree(system_config_source, system_config_path)
shutil.copy(hardware_config_path, system_config_path)

# Rebuild the system
subprocess.run(["sudo", "nixos-rebuild", "switch",
                "--flake", "/etc/nixos#nixos"])
subprocess.run(["sudo", "passwd", "yrth"])

# Clone user config
subprocess.run(["sudo", "-u", "yrth",
                "git", "clone", config_repo_url, str(config_repo_path)])

# Clone nvim config
subprocess.run(["sudo", "-u", "yrth",
                "git", "clone", nvim_config_url, str(nvim_config_path)])

# Build user config
home_build_cmd = ("export NIXPKGS_ALLOW_UNFREE=1; "
                  + "home-manager switch --impure --flake "
                  + str(config_repo_path))
subprocess.run(["sudo", "-u", "yrth", "bash", "-c", home_build_cmd])
