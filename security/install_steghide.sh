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

# Function to install Steghide
install_steghide() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Steghide on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y steghide
            ;;
        CentOS*|Red*Hat*)
            echo "Installing Steghide on CentOS/RHEL..."
            sudo yum install -y epel-release
            sudo yum install -y steghide
            ;;
        Fedora)
            echo "Installing Steghide on Fedora..."
            sudo dnf install -y steghide
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Steghide manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists steghide; then
        echo "Steghide has been successfully installed."
        steghide --version
    else
        echo "Failed to install Steghide. Please try installing it manually."
        return 1
    fi

    echo "Steghide installation completed."
    echo "You can now use Steghide to hide and extract data from image and audio files."
    echo "For usage information, type 'steghide --help'"
}

# Run the installation
install_steghide