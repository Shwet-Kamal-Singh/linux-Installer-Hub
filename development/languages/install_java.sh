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

# Function to install Java
install_java() {
    detect_os
    echo "Detected OS: $OS"

    # Prompt user for Java version
    echo "Which Java version would you like to install?"
    echo "1) OpenJDK 8"
    echo "2) OpenJDK 11"
    echo "3) OpenJDK 17"
    read -p "Enter your choice (1-3): " java_choice

    case $java_choice in
        1) java_version="openjdk-8-jdk" ;;
        2) java_version="openjdk-11-jdk" ;;
        3) java_version="openjdk-17-jdk" ;;
        *) echo "Invalid choice. Exiting."; exit 1 ;;
    esac

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Java on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y $java_version
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Java on CentOS/RHEL/Fedora..."
            case $java_choice in
                1) java_version="java-1.8.0-openjdk-devel" ;;
                2) java_version="java-11-openjdk-devel" ;;
                3) java_version="java-17-openjdk-devel" ;;
            esac
            sudo yum install -y $java_version
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Java manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists java; then
        echo "Java has been successfully installed."
        java -version
    else
        echo "Failed to install Java. Please try installing it manually."
        return 1
    fi

    # Set JAVA_HOME
    echo "Setting JAVA_HOME..."
    java_path=$(readlink -f /usr/bin/java | sed "s:bin/java::")
    echo "export JAVA_HOME=$java_path" >> $HOME/.bashrc
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> $HOME/.bashrc
    source $HOME/.bashrc

    echo "Java installation and setup completed."
}

# Run the installation
install_java