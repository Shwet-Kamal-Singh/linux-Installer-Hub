#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect the OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        OS=Debian
    elif [ -f /etc/redhat-release ]; then
        OS=RedHat
    else
        OS=$(uname -s)
    fi
}

# Function to install OBS Studio
install_obs_studio() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Linux\ Mint)
            echo "Installing OBS Studio on $OS..."
            sudo add-apt-repository -y ppa:obsproject/obs-studio
            sudo apt update
            sudo apt install -y obs-studio
            ;;
        Debian)
            echo "Installing OBS Studio on Debian..."
            sudo apt update
            sudo apt install -y ffmpeg
            sudo apt install -y obs-studio
            ;;
        CentOS*|Red*Hat*)
            echo "Installing OBS Studio on CentOS/RHEL..."
            sudo yum install -y epel-release
            sudo yum install -y https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
            sudo yum install -y obs-studio
            ;;
        Fedora)
            echo "Installing OBS Studio on Fedora..."
            sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf install -y obs-studio
            ;;
        Arch\ Linux|Manjaro)
            echo "Installing OBS Studio on Arch/Manjaro..."
            sudo pacman -S --noconfirm obs-studio
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install OBS Studio manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists obs; then
        echo "OBS Studio has been successfully installed."
        obs --version
    else
        echo "Failed to install OBS Studio. Please try installing it manually."
        return 1
    fi

    echo "OBS Studio installation completed."
    echo "You can now run OBS Studio by typing 'obs' in the terminal or launching it from your application menu."
}

# Run the installation
install_obs_studio