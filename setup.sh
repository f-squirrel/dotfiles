#!/usr/bin/env sh
set -e

# Install Nix (daemon/multi-user mode)
# shellcheck disable=SC3001
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

# Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Detect current system
arch=$(uname -m)
os=$(uname -s | tr '[:upper:]' '[:lower:]')
[ "$arch" = "arm64" ] && arch="aarch64"
system="${arch}-${os}"

# Apply Home Manager configuration directly from GitHub (no git clone needed)
# Nix fetches the flake; git will be installed as part of the configuration
nix run github:nix-community/home-manager -- switch --flake "github:f-squirrel/dotfiles#dima@${system}" -b backup
