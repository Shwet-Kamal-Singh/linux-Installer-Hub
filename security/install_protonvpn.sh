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

# Function to install ProtonVPN
install_protonvpn() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing ProtonVPN on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y openvpn dialog python3-pip python3-setuptools
            sudo pip3 install protonvpn-cli
            ;;
        CentOS*|Red*Hat*)
            echo "Installing ProtonVPN on CentOS/RHEL..."
            sudo yum install -y epel-release
            sudo yum install -y openvpn dialog python3-pip python3-setuptools
            sudo pip3 install protonvpn-cli
            ;;
        Fedora)
            echo "Installing ProtonVPN on Fedora..."
            sudo dnf install -y openvpn dialog python3-pip python3-setuptools
            sudo pip3 install protonvpn-cli
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install ProtonVPN manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists protonvpn; then
        echo "ProtonVPN has been successfully installed."
        protonvpn --version
    else
        echo "Failed to install ProtonVPN. Please try installing it manually."
        return 1
    fi

    echo "ProtonVPN installation completed."
    echo "To set up ProtonVPN, run 'sudo protonvpn init' and follow the prompts."
}

# Run the installation
install_protonvpn