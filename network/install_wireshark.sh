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

# Function to install Wireshark
install_wireshark() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Wireshark on Ubuntu/Debian..."
            sudo apt update
            sudo DEBIAN_FRONTEND=noninteractive apt install -y wireshark
            # Configure wireshark to allow non-root users to capture packets
            sudo dpkg-reconfigure wireshark-common -f noninteractive
            sudo adduser $USER wireshark
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Wireshark on CentOS/RHEL/Fedora..."
            sudo yum install -y epel-release
            sudo yum install -y wireshark wireshark-qt
            # Configure wireshark to allow non-root users to capture packets
            sudo groupadd wireshark
            sudo usermod -a -G wireshark $USER
            sudo chgrp wireshark /usr/bin/dumpcap
            sudo chmod 750 /usr/bin/dumpcap
            sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Wireshark manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists wireshark; then
        echo "Wireshark has been successfully installed."
        wireshark --version
    else
        echo "Failed to install Wireshark. Please try installing it manually."
        return 1
    fi

    echo "Wireshark installation completed."
    echo "You may need to log out and log back in for group changes to take effect."
    echo "Remember to use Wireshark responsibly and only on networks you have permission to monitor."
}

# Run the installation
install_wireshark