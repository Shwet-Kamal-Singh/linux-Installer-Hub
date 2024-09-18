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

# Function to install LibreOffice
install_libreoffice() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing LibreOffice on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y libreoffice libreoffice-gtk3
            ;;
        CentOS*|Red*Hat*)
            echo "Installing LibreOffice on CentOS/RHEL..."
            sudo yum install -y epel-release
            sudo yum install -y libreoffice
            ;;
        Fedora)
            echo "Installing LibreOffice on Fedora..."
            sudo dnf install -y libreoffice
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install LibreOffice manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists libreoffice; then
        echo "LibreOffice has been successfully installed."
        libreoffice --version
    else
        echo "Failed to install LibreOffice. Please try installing it manually."
        return 1
    fi

    echo "LibreOffice installation completed."
}

# Run the installation
install_libreoffice