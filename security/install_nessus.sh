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

# Function to install Nessus
install_nessus() {
    detect_os
    echo "Detected OS: $OS"

    # Determine system architecture
    ARCH=$(uname -m)
    if [ "$ARCH" = "x86_64" ]; then
        ARCH="amd64"
    elif [ "$ARCH" = "aarch64" ]; then
        ARCH="arm64"
    else
        echo "Unsupported architecture: $ARCH"
        return 1
    fi

    # Set Nessus version and download URL
    NESSUS_VERSION="10.5.1"
    NESSUS_URL="https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-$NESSUS_VERSION-ubuntu1404_$ARCH.deb"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Nessus on Ubuntu/Debian..."
            wget -O nessus.deb "$NESSUS_URL"
            sudo dpkg -i nessus.deb
            rm nessus.deb
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Nessus on CentOS/RHEL/Fedora..."
            NESSUS_URL="${NESSUS_URL/.deb/.rpm}"
            wget -O nessus.rpm "$NESSUS_URL"
            sudo rpm -ivh nessus.rpm
            rm nessus.rpm
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Nessus manually."
            return 1
            ;;
    esac

    # Start Nessus service
    sudo systemctl start nessusd

    echo "Nessus has been installed and started."
    echo "Please access the Nessus web interface at https://localhost:8834"
    echo "to complete the setup process and obtain your activation code."
}

# Run the installation
install_nessus