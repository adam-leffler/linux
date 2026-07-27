#!/bin/bash

# MODULE: basic.sh
# DESCRIPTION: Installs the very basic utilities of the system. 

PACKAGES=(
    # System
    gvfs                    # Gnome virtual file system 
    udisks2                 # Disks and storage device management
    tar                     # Compression

    # Basic utilities
    gnome-terminal          # Terminal
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
