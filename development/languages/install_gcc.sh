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

# Function to install GCC
install_gcc() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing GCC on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y build-essential
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing GCC on CentOS/RHEL/Fedora..."
            sudo yum group install -y "Development Tools"
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install GCC manually."
            return 1
            ;;
    esac

    if command_exists gcc; then
        echo "GCC has been successfully installed."
        gcc --version
    else
        echo "Failed to install GCC. Please try installing it manually."
        return 1
    fi

    # Install additional development libraries
    case "$OS" in
        Ubuntu|Debian)
            sudo apt install -y libc6-dev libstdc++-*-dev
            ;;
        CentOS*|Red*Hat*|Fedora)
            sudo yum install -y glibc-devel libstdc++-devel
            ;;
    esac

    echo "GCC and development libraries installation completed."
}

# Run the installation
install_gcc