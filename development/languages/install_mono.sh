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

# Function to install Mono
install_mono() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Mono on Ubuntu/Debian..."
            # Import Mono's GPG key
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
            # Add the Mono repository
            sudo sh -c 'echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" > /etc/apt/sources.list.d/mono-official-stable.list'
            # Install Mono
            sudo apt update
            sudo apt install -y mono-complete
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Mono on CentOS/RHEL/Fedora..."
            # Import Mono's GPG key
            sudo rpmkeys --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
            # Add the Mono repository
            sudo yum-config-manager --add-repo https://download.mono-project.com/repo/centos/
            # Install Mono
            sudo yum install -y mono-complete
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Mono manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists mono; then
        echo "Mono has been successfully installed."
        mono --version
    else
        echo "Failed to install Mono. Please try installing it manually."
        return 1
    fi

    echo "Mono installation completed."
}

# Run the installation
install_mono