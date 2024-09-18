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

# Function to install OpenSSH Server
install_openssh_server() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing OpenSSH Server on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y openssh-server
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing OpenSSH Server on CentOS/RHEL/Fedora..."
            sudo yum install -y openssh-server
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install OpenSSH Server manually."
            return 1
            ;;
    esac

    # Start and enable SSH service
    if command_exists systemctl; then
        sudo systemctl start sshd
        sudo systemctl enable sshd
    elif command_exists service; then
        sudo service ssh start
        sudo chkconfig ssh on
    else
        echo "Unable to start SSH service. Please start it manually."
        return 1
    fi

    # Verify installation
    if command_exists ssh; then
        echo "OpenSSH Server has been successfully installed and started."
        ssh -V
    else
        echo "Failed to install OpenSSH Server. Please try installing it manually."
        return 1
    fi

    # Configure firewall if it's active
    if command_exists ufw; then
        sudo ufw allow ssh
    elif command_exists firewall-cmd; then
        sudo firewall-cmd --permanent --add-service=ssh
        sudo firewall-cmd --reload
    fi

    echo "OpenSSH Server installation and configuration completed."
    echo "Remember to configure /etc/ssh/sshd_config for additional security settings."
}

# Run the installation
install_openssh_server