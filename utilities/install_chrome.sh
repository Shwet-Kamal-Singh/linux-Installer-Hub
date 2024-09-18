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

# Function to install Google Chrome
install_chrome() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing Google Chrome on $OS..."
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
            sudo apt update
            sudo apt install -y google-chrome-stable
            ;;
        CentOS*|Red*Hat*)
            echo "Installing Google Chrome on CentOS/RHEL..."
            sudo yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
            ;;
        Fedora)
            echo "Installing Google Chrome on Fedora..."
            sudo dnf install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Google Chrome manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists google-chrome-stable; then
        echo "Google Chrome has been successfully installed."
        google-chrome-stable --version
    else
        echo "Failed to install Google Chrome. Please try installing it manually."
        return 1
    fi

    echo "Google Chrome installation completed."
    echo "You can now run Chrome by typing 'google-chrome-stable' in the terminal or launching it from your application menu."
}

# Run the installation
install_chrome