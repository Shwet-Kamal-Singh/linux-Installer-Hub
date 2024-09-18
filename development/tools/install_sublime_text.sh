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

# Function to install Sublime Text
install_sublime_text() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Sublime Text on Ubuntu/Debian..."
            # Install dependencies
            sudo apt update
            sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

            # Add Sublime Text repository
            curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
            sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"

            # Install Sublime Text
            sudo apt update
            sudo apt install -y sublime-text
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Sublime Text on CentOS/RHEL/Fedora..."
            # Add Sublime Text repository
            sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
            sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

            # Install Sublime Text
            sudo yum install -y sublime-text
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Sublime Text manually."
            return 1
            ;;
    esac

    if command_exists subl; then
        echo "Sublime Text has been successfully installed."
        subl --version
    else
        echo "Failed to install Sublime Text. Please try installing it manually."
        return 1
    fi
}

# Run the installation
install_sublime_text