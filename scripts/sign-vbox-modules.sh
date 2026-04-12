#!/usr/bin/env bash
set -euo pipefail

# Stable MOK key — stored outside /var/lib/shim-signed/mok/ so vboxconfig
# never overwrites it. Enroll once with: sudo mokutil --import /etc/vbox-mok/MOK.der
KERNEL="${1:-$(uname -r)}"
SIGN_TOOL="/usr/src/linux-headers-${KERNEL}/scripts/sign-file"
MOK_DIR="/etc/vbox-mok"
MOK_PRIV="${MOK_DIR}/MOK.priv"
MOK_DER="${MOK_DIR}/MOK.der"
MODULES=(vboxdrv vboxnetflt vboxnetadp)

if [[ $EUID -ne 0 ]]; then
    echo "Run as root: sudo $0" >&2
    exit 1
fi

# Generate a stable key if it doesn't exist yet
if [[ ! -f "$MOK_PRIV" ]]; then
    echo "Generating stable MOK key in ${MOK_DIR}..."
    mkdir -p "$MOK_DIR"
    chmod 700 "$MOK_DIR"
    openssl req -new -x509 -newkey rsa:2048 -keyout "$MOK_PRIV" -out "$MOK_DER" \
        -days 36500 -subj "/CN=VirtualBox-stable/" -nodes -outform DER 2>/dev/null
    chmod 600 "$MOK_PRIV"
    echo ""
    echo "KEY GENERATED. You must enroll it once and reboot:"
    echo "  sudo mokutil --import ${MOK_DER}"
    echo "Then reboot and confirm enrollment in the MOK manager."
    exit 0
fi

# Check the key is actually enrolled
if ! mokutil --test-key "$MOK_DER" &>/dev/null; then
    echo "ERROR: Key ${MOK_DER} is not enrolled in Secure Boot." >&2
    echo "Run: sudo mokutil --import ${MOK_DER}" >&2
    echo "Then reboot and confirm enrollment in the MOK manager." >&2
    exit 1
fi

for mod in "${MODULES[@]}"; do
    mod_path="$(modinfo -n "$mod" 2>/dev/null || true)"
    if [[ -z "$mod_path" ]]; then
        echo "Module $mod not found, skipping"
        continue
    fi
    echo "Signing $mod ($mod_path)..."
    "$SIGN_TOOL" sha256 "$MOK_PRIV" "$MOK_DER" "$mod_path"
done

echo "Loading vboxdrv..."
modprobe vboxdrv
echo "Done."
