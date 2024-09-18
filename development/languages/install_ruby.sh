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

# Function to install Ruby
install_ruby() {
    detect_os
    echo "Detected OS: $OS"

    # Prompt user for Ruby version
    echo "Which Ruby version would you like to install?"
    echo "1) Ruby 2.7"
    echo "2) Ruby 3.0"
    echo "3) Ruby 3.1"
    read -p "Enter your choice (1-3): " ruby_choice

    case $ruby_choice in
        1) RUBY_VERSION="2.7" ;;
        2) RUBY_VERSION="3.0" ;;
        3) RUBY_VERSION="3.1" ;;
        *) echo "Invalid choice. Exiting."; exit 1 ;;
    esac

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Ruby on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y software-properties-common
            sudo add-apt-repository -y ppa:brightbox/ruby-ng
            sudo apt update
            sudo apt install -y ruby$RUBY_VERSION ruby$RUBY_VERSION-dev
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Ruby on CentOS/RHEL/Fedora..."
            sudo yum install -y epel-release
            sudo yum install -y https://github.com/rbenv/ruby-build/archive/v20211227.tar.gz
            sudo yum install -y gcc-c++ patch readline-devel zlib-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison
            sudo ruby-build-20211227/bin/ruby-build $RUBY_VERSION /usr/local
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Ruby manually."
            return 1
            ;;
    esac

    # Install Bundler
    echo "Installing Bundler..."
    sudo gem install bundler

    # Verify installation
    if command_exists ruby; then
        echo "Ruby has been successfully installed."
        ruby --version
        gem --version
        bundler --version
    else
        echo "Failed to install Ruby. Please try installing it manually."
        return 1
    fi

    echo "Ruby installation completed."
}

# Run the installation
install_ruby