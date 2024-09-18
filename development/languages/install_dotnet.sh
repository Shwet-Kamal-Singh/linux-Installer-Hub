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

# Function to install .NET SDK
install_dotnet() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing .NET SDK on Ubuntu/Debian..."
            # Add Microsoft package repository
            wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
            sudo dpkg -i packages-microsoft-prod.deb
            rm packages-microsoft-prod.deb

            # Install .NET SDK
            sudo apt-get update
            sudo apt-get install -y apt-transport-https
            sudo apt-get update
            sudo apt-get install -y dotnet-sdk-6.0
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing .NET SDK on CentOS/RHEL/Fedora..."
            # Add Microsoft package repository
            sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm

            # Install .NET SDK
            sudo yum install -y dotnet-sdk-6.0
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install .NET SDK manually."
            return 1
            ;;
    esac

    if command_exists dotnet; then
        echo ".NET SDK has been successfully installed."
        dotnet --version
    else
        echo "Failed to install .NET SDK. Please try installing it manually."
        return 1
    fi
}

# Run the installation
install_dotnet