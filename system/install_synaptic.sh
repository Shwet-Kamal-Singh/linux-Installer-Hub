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

# Function to install Synaptic
install_synaptic() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint|elementary\ OS|Zorin\ OS)
            echo "Installing Synaptic on $OS..."
            sudo apt update
            sudo apt install -y synaptic
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Synaptic is primarily for Debian-based systems."
            echo "Please install a suitable package manager for your system manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists synaptic; then
        echo "Synaptic has been successfully installed."
        synaptic --version
    else
        echo "Failed to install Synaptic. Please try installing it manually."
        return 1
    fi

    echo "Synaptic installation completed."
    echo "You can now run Synaptic by typing 'sudo synaptic' in the terminal."
    echo "Remember that Synaptic requires root privileges to manage packages."
}

# Run the installation
install_synaptic