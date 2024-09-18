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

# Function to install Etcher
install_etcher() {
    detect_os
    echo "Detected OS: $OS"

    ETCHER_VERSION="1.7.9"
    ETCHER_ARCH="x64"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing Etcher on $OS..."
            wget -O balena-etcher.deb "https://github.com/balena-io/etcher/releases/download/v${ETCHER_VERSION}/balena-etcher_${ETCHER_VERSION}_amd64.deb"
            sudo apt install -y ./balena-etcher.deb
            rm balena-etcher.deb
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Etcher on $OS..."
            wget -O balena-etcher.rpm "https://github.com/balena-io/etcher/releases/download/v${ETCHER_VERSION}/balena-etcher-${ETCHER_VERSION}.x86_64.rpm"
            if command_exists dnf; then
                sudo dnf install -y ./balena-etcher.rpm
            else
                sudo yum localinstall -y ./balena-etcher.rpm
            fi
            rm balena-etcher.rpm
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Etcher manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists balena-etcher-electron || command_exists etcher-electron; then
        echo "Etcher (balenaEtcher) has been successfully installed."
        echo "You can now run Etcher from your application menu or by typing 'balena-etcher' in the terminal."
    else
        echo "Failed to install Etcher. Please try installing it manually."
        return 1
    fi

    echo "Etcher installation completed."
}

# Run the installation
install_etcher