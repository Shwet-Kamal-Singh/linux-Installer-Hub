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

# Function to install Docker
install_docker() {
    detect_os
    echo "Detected OS: $OS"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing Docker on $OS..."
            sudo apt update
            sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            sudo apt update
            sudo apt install -y docker-ce docker-ce-cli containerd.io
            ;;
        CentOS*|Red*Hat*)
            echo "Installing Docker on CentOS/RHEL..."
            sudo yum install -y yum-utils
            sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
            sudo yum install -y docker-ce docker-ce-cli containerd.io
            ;;
        Fedora)
            echo "Installing Docker on Fedora..."
            sudo dnf -y install dnf-plugins-core
            sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
            sudo dnf install -y docker-ce docker-ce-cli containerd.io
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Docker manually."
            return 1
            ;;
    esac

    # Start and enable Docker service
    sudo systemctl start docker
    sudo systemctl enable docker

    # Add current user to docker group
    sudo usermod -aG docker $USER

    # Verify installation
    if command_exists docker; then
        echo "Docker has been successfully installed."
        docker --version
    else
        echo "Failed to install Docker. Please try installing it manually."
        return 1
    fi

    echo "Docker installation completed."
    echo "You may need to log out and log back in for group changes to take effect."
    echo "To verify Docker is working, run: docker run hello-world"
}

# Function to install Docker Compose
install_docker_compose() {
    echo "Installing Docker Compose..."
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
    sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    if command_exists docker-compose; then
        echo "Docker Compose has been successfully installed."
        docker-compose --version
    else
        echo "Failed to install Docker Compose. Please try installing it manually."
        return 1
    fi
}

# Main installation process
echo "This script will install Docker and optionally Docker Compose."
install_docker

read -p "Do you want to install Docker Compose as well? (y/n): " install_compose
if [[ $install_compose =~ ^[Yy]$ ]]; then
    install_docker_compose
fi

echo "Installation process completed."
echo "You may need to log out and log back in for group changes to take effect."