#!/usr/bin/env bash

sudo nix-shell -p git home-manager python313 --run "python3 scripts/configure.py"
