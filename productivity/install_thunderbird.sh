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

# Function to install Thunderbird
install_thunderbird() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Thunderbird on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y thunderbird
            ;;
        CentOS*|Red*Hat*)
            echo "Installing Thunderbird on CentOS/RHEL..."
            sudo yum install -y epel-release
            sudo yum install -y thunderbird
            ;;
        Fedora)
            echo "Installing Thunderbird on Fedora..."
            sudo dnf install -y thunderbird
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Thunderbird manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists thunderbird; then
        echo "Thunderbird has been successfully installed."
        thunderbird --version
    else
        echo "Failed to install Thunderbird. Please try installing it manually."
        return 1
    fi

    echo "Thunderbird installation completed."
}

# Run the installation
install_thunderbird