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

# Function to install Nextcloud Client
install_nextcloud_client() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Nextcloud Client on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y software-properties-common
            sudo add-apt-repository -y ppa:nextcloud-devs/client
            sudo apt update
            sudo apt install -y nextcloud-client
            ;;
        CentOS*|Red*Hat*)
            echo "Installing Nextcloud Client on CentOS/RHEL..."
            sudo rpm --import https://download.nextcloud.com/desktop/repositories/CentOS_7/repodata/repomd.xml.key
            sudo yum-config-manager --add-repo https://download.nextcloud.com/desktop/repositories/CentOS_7/Nextcloud.repo
            sudo yum install -y nextcloud-client
            ;;
        Fedora)
            echo "Installing Nextcloud Client on Fedora..."
            sudo dnf install -y nextcloud-client
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Nextcloud Client manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists nextcloud; then
        echo "Nextcloud Client has been successfully installed."
        nextcloud --version
    else
        echo "Failed to install Nextcloud Client. Please try installing it manually."
        return 1
    fi

    echo "Nextcloud Client installation completed."
}

# Run the installation
install_nextcloud_client