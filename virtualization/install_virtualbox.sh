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

# Function to install VirtualBox
install_virtualbox() {
    detect_os
    echo "Detected OS: $OS"

    VIRTUALBOX_VERSION="6.1"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing VirtualBox on $OS..."
            sudo apt update
            sudo apt install -y software-properties-common apt-transport-https wget
            wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
            echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
            sudo apt update
            sudo apt install -y virtualbox-$VIRTUALBOX_VERSION
            ;;
        CentOS*|Red*Hat*)
            echo "Installing VirtualBox on CentOS/RHEL..."
            sudo yum install -y wget
            wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo
            sudo yum install -y VirtualBox-$VIRTUALBOX_VERSION
            ;;
        Fedora)
            echo "Installing VirtualBox on Fedora..."
            sudo dnf install -y wget
            wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo
            sudo dnf install -y VirtualBox-$VIRTUALBOX_VERSION
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install VirtualBox manually."
            return 1
            ;;
    esac

    # Install VirtualBox Extension Pack
    VBOX_VERSION=$(vboxmanage -v)
    VBOX_VERSION_MAJOR=$(echo $VBOX_VERSION | cut -d 'r' -f 1)
    wget https://download.virtualbox.org/virtualbox/$VBOX_VERSION_MAJOR/Oracle_VM_VirtualBox_Extension_Pack-$VBOX_VERSION_MAJOR.vbox-extpack
    echo y | sudo VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-$VBOX_VERSION_MAJOR.vbox-extpack
    rm Oracle_VM_VirtualBox_Extension_Pack-$VBOX_VERSION_MAJOR.vbox-extpack

    # Verify installation
    if command_exists virtualbox; then
        echo "VirtualBox has been successfully installed."
        vboxmanage --version
    else
        echo "Failed to install VirtualBox. Please try installing it manually."
        return 1
    fi

    echo "VirtualBox installation completed."
    echo "You can now run VirtualBox by typing 'virtualbox' in the terminal or launching it from your application menu."
}

# Run the installation
install_virtualbox