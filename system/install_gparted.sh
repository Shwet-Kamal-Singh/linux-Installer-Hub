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

# Function to install GParted
install_gparted() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing GParted on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y gparted
            ;;
        CentOS*|Red*Hat*)
            echo "Installing GParted on CentOS/RHEL..."
            sudo yum install -y epel-release
            sudo yum install -y gparted
            ;;
        Fedora)
            echo "Installing GParted on Fedora..."
            sudo dnf install -y gparted
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install GParted manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists gparted; then
        echo "GParted has been successfully installed."
        gparted --version
    else
        echo "Failed to install GParted. Please try installing it manually."
        return 1
    fi

    echo "GParted installation completed."
    echo "You can now run GParted by typing 'sudo gparted' in the terminal."
    echo "Remember to use GParted with caution as it can modify partition tables."
}

# Run the installation
install_gparted