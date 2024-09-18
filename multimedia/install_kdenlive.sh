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

# Function to install Kdenlive
install_kdenlive() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Kdenlive on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y software-properties-common
            sudo add-apt-repository -y ppa:kdenlive/kdenlive-stable
            sudo apt update
            sudo apt install -y kdenlive
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Kdenlive on CentOS/RHEL/Fedora..."
            sudo yum install -y epel-release
            sudo yum install -y kdenlive
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Kdenlive manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists kdenlive; then
        echo "Kdenlive has been successfully installed."
        kdenlive --version
    else
        echo "Failed to install Kdenlive. Please try installing it manually."
        return 1
    fi

    echo "Kdenlive installation completed."
}

# Run the installation
install_kdenlive