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

# Function to install Dart
install_dart() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Dart on Ubuntu/Debian..."
            # Add the Dart repository
            sudo apt-get update
            sudo apt-get install -y apt-transport-https
            sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
            sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
            
            # Install Dart
            sudo apt-get update
            sudo apt-get install -y dart
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Dart on CentOS/RHEL/Fedora..."
            # Add the Dart repository
            sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | tee /etc/yum.repos.d/dart.repo'
            sudo sh -c 'echo -e "[dart]\nname=Dart\nbaseurl=https://storage.googleapis.com/download.dartlang.org/linux/redhat/x86_64\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/dart.repo'
            
            # Install Dart
            sudo yum install -y dart
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Dart manually."
            return 1
            ;;
    esac

    # Add Dart to PATH
    echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.bashrc
    source ~/.bashrc

    if command_exists dart; then
        echo "Dart has been successfully installed."
        dart --version
    else
        echo "Failed to install Dart. Please try installing it manually."
        return 1
    fi
}

# Run the installation
install_dart