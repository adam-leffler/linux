#!/bin/bash

################################################################################################################################
#                                                           WELCOME                                                            #
################################################################################################################################

echo "Welcome to the ultimate Fedora configuration."
sleep 1
echo "Be aware that the current instance will configure the system with proprietary Nvidia drivers, GNOME and Wayland."
sleep 2
echo "Multiple third-party repositories and proprietary softwares will be added."
sleep 2
echo "Installation will begin in 3 seconds..."
sleep 3 
echo "Installation has begun."

################################################################################################################################
#                                                         REPOSITORIES                                                         #
################################################################################################################################


sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager setopt google-chrome.enabled=1
sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/network:im:signal/Fedora_42/network:im:signal.repo
sudo dnf makecache
sudo dnf upgrade -y


################################################################################################################################
#                                                            SYSTEM                                                            #
################################################################################################################################


# Nvidia
sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-settings nvidia-persistenced

# Vendor Neutral Dispatch
sudo dnf install -y libglvnd-opengl libglvnd-glx

# Wayland
sudo dnf install -y xorg-x11-server-Xwayland

# GNOME Desktop environment 
sudo dnf install -y mutter gnome-session-wayland-session gnome-shell gdm
sudo systemctl enable gdm.service

sudo systemctl set-default graphical.target



################################################################################################################################
#                                                         APPLICATIONS                                                         #
################################################################################################################################



# Basic utilities 
sudo dnf install -y gnome-terminal nautilus gnome-control-center gparted 
sudo dnf install -y gnome-text-editor xed vi vim nano
sudo dnf install -y fastfetch htop
sudo dnf install -y gvfs udisks2 tar
sudo dnf install -y timeshift

# Customization
sudo dnf install -y gnome-extensions-app gnome-browser-connector gnome-tweaks openrgb
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
sudo dnf install -y papirus-icon-theme

# Internet
sudo dnf install -y wget
sudo dnf install -y firefox chromium google-chrome-stable torbrowser-launcher icecat qutebrowser
sudo dnf install -y discord signal-desktop

# Office 
sudo dnf install -y libreoffice gnome-calculator

# Development
sudo dnf install -y make gcc g++ gcc-c++ nasm
sudo dnf install -y git 
sudo dnf install -y python3 python3-devel python3-pip

# Media and graphics
sudo dnf install -y vlc eog 
sudo dnf install -y video-downloader
sudo dnf install -y ffmpeg gimp obs-studio kdenlive blender

# Virtualization
sudo dnf install -y kernel-devel-$(uname -r) 
sudo dnf install -y kernel-headers
sudo dnf install -y qemu qemu-kvm libvirt virt-manager
sudo dnf install -y VirtualBox akmod-VirtualBox 
sudo systemctl start vboxdrv.service
sudo systemctl enable vboxdrv.service
sudo usermod -a -G vboxusers $USER



################################################################################################################################
#                                                            FINISH                                                            #
################################################################################################################################



sudo dnf clean all -y
fastfetch
echo "Installation complete. Rebooting in 10 seconds."
sleep 10
echo "Bye!"
sudo reboot 
