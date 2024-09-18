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

# Function to install Go
install_go() {
    # Set Go version
    GO_VERSION="1.17.6"  # Update this to the latest version as needed

    detect_os
    echo "Detected OS: $OS"

    # Download and install Go
    echo "Downloading Go version $GO_VERSION..."
    wget https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz

    echo "Extracting Go..."
    sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz

    # Set up Go environment variables
    echo "Setting up Go environment..."
    echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.bashrc
    echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
    echo 'export PATH=$PATH:$GOPATH/bin' >> $HOME/.bashrc

    # Reload .bashrc
    source $HOME/.bashrc

    # Clean up downloaded archive
    rm go$GO_VERSION.linux-amd64.tar.gz

    # Verify installation
    if command_exists go; then
        echo "Go has been successfully installed."
        go version
    else
        echo "Failed to install Go. Please try installing it manually."
        return 1
    fi

    echo "Go installation completed."
}

# Run the installation
install_go