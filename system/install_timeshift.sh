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
    else
        OS=$(uname -s)
    fi
}

# Function to install Timeshift
install_timeshift() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint|elementary\ OS|Zorin\ OS)
            echo "Installing Timeshift on $OS..."
            sudo apt update
            sudo apt install -y timeshift
            ;;
        Fedora)
            echo "Installing Timeshift on Fedora..."
            sudo dnf install -y timeshift
            ;;
        CentOS*|Red*Hat*)
            echo "Installing Timeshift on CentOS/RHEL..."
            sudo yum install -y epel-release
            sudo yum install -y timeshift
            ;;
        Arch\ Linux|Manjaro)
            echo "Installing Timeshift on Arch/Manjaro..."
            sudo pacman -Sy --noconfirm timeshift
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Timeshift manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists timeshift; then
        echo "Timeshift has been successfully installed."
        timeshift --version
    else
        echo "Failed to install Timeshift. Please try installing it manually."
        return 1
    fi

    echo "Timeshift installation completed."
    echo "You can now run Timeshift by typing 'sudo timeshift' in the terminal."
    echo "Remember to configure Timeshift and create your first snapshot."
}

# Run the installation
install_timeshift