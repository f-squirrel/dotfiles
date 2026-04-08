#!/usr/bin/env sh
set -e

profile="${1:?Usage: sh setup.sh <profile>  (e.g. full, dev, minimal)}"

# Install Nix (daemon/multi-user mode)
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install -o /tmp/nix-install.sh
sh /tmp/nix-install.sh --daemon --yes
rm /tmp/nix-install.sh

# Source Nix in the current shell session (the installer does not update PATH)
# shellcheck disable=SC1091
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Enable flakes (write to system config so it works regardless of HOME ownership)
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

# User identity
username="${USER}"
git_name="${GIT_NAME:-f-squirrel}"
git_email="${GIT_EMAIL:-dmitry.b.danilov@gmail.com}"

# Detect current system
arch=$(uname -m)
os=$(uname -s | tr '[:upper:]' '[:lower:]')
[ "$arch" = "arm64" ] && arch="aarch64"
system="${arch}-${os}"

# Apply configuration directly from GitHub (no git clone needed)
# Nix fetches the flake; git will be installed as part of the configuration
if [ "$os" = "darwin" ]; then
    USERNAME="$username" GIT_NAME="$git_name" GIT_EMAIL="$git_email" \
        sudo nix run github:nix-darwin/nix-darwin/master#darwin-rebuild -- switch --impure \
        --flake "github:f-squirrel/dotfiles#${username}-${profile}@${system}"
else
    USERNAME="$username" GIT_NAME="$git_name" GIT_EMAIL="$git_email" \
        nix run github:nix-community/home-manager -- switch --impure \
        --flake "github:f-squirrel/dotfiles#${username}-${profile}@${system}" -b backup

    # Set up GPU drivers if running on non-NixOS Linux (script absent on NixOS)
    gpu_setup=$(find /nix/store -maxdepth 3 -name "non-nixos-gpu-setup" 2>/dev/null | head -1)
    if [ -n "$gpu_setup" ]; then
        sudo "$gpu_setup"
    fi
fi
