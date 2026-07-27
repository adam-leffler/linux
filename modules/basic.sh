#!/bin/bash

# MODULE: basic.sh
# DESCRIPTION: Installs the very basic utilities of the system, configures Fastfetch and creates a systemd user service for Rclone mounting

PACKAGES=(
    # System
    gvfs                    # Gnome virtual file system 
    udisks2                 # Disks and storage device management
    tar                     # Compression

    # Basic utilities
    ptyxis                  # Terminal
    nautilus                # File manager
    gnome-control-center    # Settings app
    gparted                 # Disk manager
    rclone                  # Cloud connectivity
    fastfetch               # Terminal utility
    htop                    # Task manager

    # Text editors
    gnome-text-editor       # GNOME Text Editor
    xed                     # X-Apps Editor
    vim                     # VI Improved
    nano                    # Small text editor
    neovim                  # VIM-fork
)


sudo dnf install -y "${PACKAGES[@]}"



# Rsync user service for automatic mounting 

TARGET_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$TARGET_USER")
TARGET_UID=$(id -u "$TARGET_USER")

mkdir -p "$USER_HOME/Cloud"
mkdir -p "$USER_HOME/.config/systemd/user"

cat <<EOF > "$USER_HOME/.config/systemd/user/rclone-gdrive.service"
[Unit]
Description=Rclone mount for Google Drive
AssertPathIsDirectory=%h/Cloud
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/rclone mount --vfs-cache-mode full google-drive:/ %h/Cloud
ExecStop=/usr/bin/fusermount3 -uz %h/Cloud
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
EOF

chown "$TARGET_USER:$TARGET_USER" "$USER_HOME/.config/systemd/user/rclone-gdrive.service"

sudo -u "$TARGET_USER" XDG_RUNTIME_DIR="/run/user/$TARGET_UID" systemctl --user daemon-reload
sudo -u "$TARGET_USER" XDG_RUNTIME_DIR="/run/user/$TARGET_UID" systemctl --user enable rclone-gdrive.service



# Configuration of Fastfetch

cat << 'EOF' > "$USER_HOME/.config/fastfetch/config.jsonc"
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "modules": [
    "title",
    "separator",
    "os",
    "kernel",
    "uptime",
    "packages",
    "de",
    "terminal",
    "cpu",
    "gpu",
    "memory",
    "disk",
    "localip",
  ]
}
EOF

chown -R "$TARGET_USER:$TARGET_USER" "$USER_HOME/.config/fastfetch"

BASHRC="$USER_HOME/.bashrc"

if [ -f "$BASHRC" ] && ! grep -qxF "fastfetch" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "fastfetch" >> "$BASHRC"
fi
