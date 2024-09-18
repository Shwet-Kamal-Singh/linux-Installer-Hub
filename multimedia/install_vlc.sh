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

# Function to install VLC
install_vlc() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing VLC on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y vlc
            ;;
        CentOS*|Red*Hat*)
            echo "Installing VLC on CentOS/RHEL..."
            sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
            sudo yum install -y https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
            sudo yum install -y vlc
            ;;
        Fedora)
            echo "Installing VLC on Fedora..."
            sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf install -y vlc
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install VLC manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists vlc; then
        echo "VLC has been successfully installed."
        vlc --version
    else
        echo "Failed to install VLC. Please try installing it manually."
        return 1
    fi

    echo "VLC installation completed."
}

# Run the installation
install_vlc