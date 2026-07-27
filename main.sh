#!bin/bash

# SCRIPT: main.sh
# DESCRIPTION: Orchestrates Fedora system setup via modular subscripts. After finished, it reboots the system.
# USAGE: bash ./main.sh (Run as user, script handles sudo internally)
# MODULES: Expected in ./modules directory

# Getting super user permissions
sudo -v 

# Runtime variable setup
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Starting messages
echo "Welcome to the ultimate Fedora configuration."
sleep 1
echo "Please, before letting this script run, feel free take a moment, cancel via a KeyboardInterrupt, and read the bash files thoroughly."
sleep 2
echo "Press Ctrl + C to cancel. The script starts in 5 seconds."
sleep 5
echo "Starting..."
sleep 1


# Initializing repositories
bash "$SCRIPT_DIR/modules/repositories.sh"

# Necessary build packages
bash "$SCRIPT_DIR/modules/build.sh"

# Nvidia drivers and kernel modules
#bash "$SCRIPT_DIR/modules/nvidia.sh"

# Display server and desktop environment
bash "$SCRIPT_DIR/modules/graphical.sh"

# Basic utilities and text editors
bash "$SCRIPT_DIR/modules/basic.sh"

# Development packages and environments
bash "$SCRIPT_DIR/modules/development.sh"

# Virtualization
#bash "$SCRIPT_DIR/modules/virtualization.sh"

# Productive software
bash "$SCRIPT_DIR/modules/office.sh"

# Internet use
bash "$SCRIPT_DIR/modules/internet.sh"

# Customization
bash "$SCRIPT_DIR/modules/customization.sh"


# Closing messages and rebooting
echo "Installation complete, rebooting in 10 seconds."
sleep 10
echo "Goodbye!"
sleep 1
sudo reboot
