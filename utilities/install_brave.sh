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

# Function to install Brave
install_brave() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing Brave on $OS..."
            sudo apt install -y apt-transport-https curl
            sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
            echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
            sudo apt update
            sudo apt install -y brave-browser
            ;;
        CentOS*|Red*Hat*)
            echo "Installing Brave on CentOS/RHEL..."
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf install -y brave-browser
            ;;
        Fedora)
            echo "Installing Brave on Fedora..."
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf install -y brave-browser
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Brave manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists brave-browser; then
        echo "Brave browser has been successfully installed."
        brave-browser --version
    else
        echo "Failed to install Brave browser. Please try installing it manually."
        return 1
    fi

    echo "Brave browser installation completed."
    echo "You can now run Brave by typing 'brave-browser' in the terminal or launching it from your application menu."
}

# Run the installation
install_brave