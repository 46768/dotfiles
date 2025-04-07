from pathlib import Path
import shutil
import subprocess

system_config_source = Path("nixos")
system_config_path = Path("/etc/nixos")

repo_url = "https://github.com/46768/dotfiles.git"


# Backup current config
system_config_backup = Path("/etc/nixos.backup")
system_config_backup.mkdir()

shutil.copytree(system_config_path, system_config_backup)

# Delete current config
shutil.rmtree(system_config_path)
system_config_path.mkdir()  # Create it back

# Apply system config
shutil.copytree(system_config_source, system_config_path)

# Rebuild the system
subprocess.run(["sudo", "nixos-rebuild", "switch",
                "--flake", "/etc/nixos#nixos"])
subprocess.run(["sudo", "passwd", "yrth"])
