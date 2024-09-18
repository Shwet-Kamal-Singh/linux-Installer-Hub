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

# Function to install GIMP
install_gimp() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing GIMP on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y gimp
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing GIMP on CentOS/RHEL/Fedora..."
            sudo yum install -y epel-release
            sudo yum install -y gimp
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install GIMP manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists gimp; then
        echo "GIMP has been successfully installed."
        gimp --version
    else
        echo "Failed to install GIMP. Please try installing it manually."
        return 1
    fi

    echo "GIMP installation completed."
}

# Run the installation
install_gimp