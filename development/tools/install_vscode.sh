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

# Function to install Visual Studio Code
install_vscode() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Visual Studio Code on Ubuntu/Debian..."
            # Install dependencies
            sudo apt update
            sudo apt install -y software-properties-common apt-transport-https wget

            # Import the Microsoft GPG key
            wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

            # Add the VS Code repository
            sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

            # Install VS Code
            sudo apt update
            sudo apt install -y code
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Visual Studio Code on CentOS/RHEL/Fedora..."
            # Import the Microsoft GPG key
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

            # Add the VS Code repository
            sudo tee /etc/yum.repos.d/vscode.repo << EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

            # Install VS Code
            sudo yum install -y code
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Visual Studio Code manually."
            return 1
            ;;
    esac

    if command_exists code; then
        echo "Visual Studio Code has been successfully installed."
        code --version
    else
        echo "Failed to install Visual Studio Code. Please try installing it manually."
        return 1
    fi
}

# Run the installation
install_vscode