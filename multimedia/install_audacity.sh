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

# Function to install Audacity
install_audacity() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Audacity on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y audacity
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Audacity on CentOS/RHEL/Fedora..."
            sudo yum install -y epel-release
            sudo yum install -y audacity
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Audacity manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists audacity; then
        echo "Audacity has been successfully installed."
        audacity --version
    else
        echo "Failed to install Audacity. Please try installing it manually."
        return 1
    fi

    echo "Audacity installation completed."
}

# Run the installation
install_audacity