import 'repo-setup/justfile'

username := "dima"

# Apply Home Manager configuration for the current system
apply:
    #!/usr/bin/env sh
    arch=$(uname --machine)
    os=$(uname --kernel-name | tr '[:upper:]' '[:lower:]')
    [ "$arch" = "arm64" ] && arch="aarch64"
    home-manager switch --flake ".#{{ username }}@${arch}-${os}"

# Update all flake inputs
update:
    nix flake update
