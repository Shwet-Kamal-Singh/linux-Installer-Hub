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

# Function to install Python
install_python() {
    detect_os
    echo "Detected OS: $OS"

    # Prompt user for Python version
    echo "Which Python version would you like to install?"
    echo "1) Python 3.8"
    echo "2) Python 3.9"
    echo "3) Python 3.10"
    read -p "Enter your choice (1-3): " python_choice

    case $python_choice in
        1) PYTHON_VERSION="3.8" ;;
        2) PYTHON_VERSION="3.9" ;;
        3) PYTHON_VERSION="3.10" ;;
        *) echo "Invalid choice. Exiting."; exit 1 ;;
    esac

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Python on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y software-properties-common
            sudo add-apt-repository -y ppa:deadsnakes/ppa
            sudo apt update
            sudo apt install -y python$PYTHON_VERSION python$PYTHON_VERSION-venv python$PYTHON_VERSION-dev
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Python on CentOS/RHEL/Fedora..."
            sudo yum update -y
            sudo yum install -y epel-release
            sudo yum install -y python$PYTHON_VERSION python$PYTHON_VERSION-devel
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Python manually."
            return 1
            ;;
    esac

    # Create symlinks if they don't exist
    if [ ! -f /usr/bin/python3 ]; then
        sudo ln -s /usr/bin/python$PYTHON_VERSION /usr/bin/python3
    fi
    if [ ! -f /usr/bin/python ]; then
        sudo ln -s /usr/bin/python$PYTHON_VERSION /usr/bin/python
    fi

    # Install pip
    echo "Installing pip..."
    sudo apt install -y python3-pip || sudo yum install -y python3-pip

    # Verify installation
    if command_exists python$PYTHON_VERSION; then
        echo "Python has been successfully installed."
        python$PYTHON_VERSION --version
        pip3 --version
    else
        echo "Failed to install Python. Please try installing it manually."
        return 1
    fi

    echo "Python installation completed."
}

# Run the installation
install_python