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

# Function to install AnyDesk
install_anydesk() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing AnyDesk on $OS..."
            wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
            echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
            sudo apt update
            sudo apt install -y anydesk
            ;;
        CentOS*|Red*Hat*)
            echo "Installing AnyDesk on CentOS/RHEL..."
            sudo rpm --import https://keys.anydesk.com/repos/RPM-GPG-KEY
            cat << EOF | sudo tee /etc/yum.repos.d/AnyDesk-CentOS.repo
[anydesk]
name=AnyDesk CentOS - stable
baseurl=http://rpm.anydesk.com/centos/\$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF
            sudo yum install -y anydesk
            ;;
        Fedora)
            echo "Installing AnyDesk on Fedora..."
            sudo dnf install -y https://download.anydesk.com/linux/anydesk_6.1.1-1_x86_64.rpm
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install AnyDesk manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists anydesk; then
        echo "AnyDesk has been successfully installed."
        anydesk --version
    else
        echo "Failed to install AnyDesk. Please try installing it manually."
        return 1
    fi

    echo "AnyDesk installation completed."
    echo "You can now run AnyDesk by typing 'anydesk' in the terminal."
}

# Run the installation
install_anydesk