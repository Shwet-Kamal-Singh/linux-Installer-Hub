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

# Function to install Clang
install_clang() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Clang on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y clang
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Clang on CentOS/RHEL/Fedora..."
            sudo yum update -y
            sudo yum install -y clang
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Clang manually."
            return 1
            ;;
    esac

    if command_exists clang; then
        echo "Clang has been successfully installed."
        clang --version
    else
        echo "Failed to install Clang. Please try installing it manually."
        return 1
    fi
}

# Run the installation
install_clang