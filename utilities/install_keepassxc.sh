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

# Function to install KeePassXC
install_keepassxc() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing KeePassXC on $OS..."
            sudo add-apt-repository -y ppa:phoerious/keepassxc
            sudo apt update
            sudo apt install -y keepassxc
            ;;
        CentOS*|Red*Hat*)
            echo "Installing KeePassXC on CentOS/RHEL..."
            sudo yum install -y epel-release
            sudo yum install -y keepassxc
            ;;
        Fedora)
            echo "Installing KeePassXC on Fedora..."
            sudo dnf install -y keepassxc
            ;;
        Arch\ Linux|Manjaro)
            echo "Installing KeePassXC on Arch/Manjaro..."
            sudo pacman -S --noconfirm keepassxc
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install KeePassXC manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists keepassxc; then
        echo "KeePassXC has been successfully installed."
        keepassxc --version
    else
        echo "Failed to install KeePassXC. Please try installing it manually."
        return 1
    fi

    echo "KeePassXC installation completed."
    echo "You can now run KeePassXC by typing 'keepassxc' in the terminal or launching it from your application menu."
}

# Run the installation
install_keepassxc