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

# Function to install Node.js
install_nodejs() {
    detect_os
    echo "Detected OS: $OS"

    # Prompt user for Node.js version
    echo "Which Node.js version would you like to install?"
    echo "1) Node.js 14.x LTS"
    echo "2) Node.js 16.x LTS"
    echo "3) Node.js 18.x LTS"
    read -p "Enter your choice (1-3): " node_choice

    case $node_choice in
        1) NODE_MAJOR=14 ;;
        2) NODE_MAJOR=16 ;;
        3) NODE_MAJOR=18 ;;
        *) echo "Invalid choice. Exiting."; exit 1 ;;
    esac

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Node.js on Ubuntu/Debian..."
            # Install dependencies
            sudo apt update
            sudo apt install -y curl
            # Setup NodeSource repository
            curl -fsSL https://deb.nodesource.com/setup_$NODE_MAJOR.x | sudo -E bash -
            # Install Node.js
            sudo apt install -y nodejs
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Node.js on CentOS/RHEL/Fedora..."
            # Install dependencies
            sudo yum install -y curl
            # Setup NodeSource repository
            curl -fsSL https://rpm.nodesource.com/setup_$NODE_MAJOR.x | sudo bash -
            # Install Node.js
            sudo yum install -y nodejs
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Node.js manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists node; then
        echo "Node.js has been successfully installed."
        node --version
        npm --version
    else
        echo "Failed to install Node.js. Please try installing it manually."
        return 1
    fi

    echo "Node.js installation completed."
}

# Run the installation
install_nodejs