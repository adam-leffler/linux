#!/bin/bash

# MODULE: internet.sh
# DESCRIPTION: Installs internet software, such as browsers and messaging apps. 
# WARNING: Contains proprietary software.

PACKAGES=(
    # Tools
    wget                    # File and recursive website downloader
    video-downloader        # Video downloader tool

    # Browsers
    google-chrome-stable    # Google Chrome
    firefox                 # Mozzila Firefox
    chromium                # Vanilla Chromium
    torbrowser-launcher     # Tor 
    icecat                  # Icecat 
    qutebrowser             # QuteBrowser

    # Messaging
    #discord                 # Discord
    #signal-desktop          # Signal Messenger
)

sudo dnf install -y "${PACKAGES[@]}"
