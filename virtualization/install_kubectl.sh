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

# Function to install kubectl
install_kubectl() {
    detect_os
    echo "Detected OS: $OS"

    # Get the latest stable version of kubectl
    KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing kubectl on $OS..."
            sudo apt update
            sudo apt install -y apt-transport-https ca-certificates curl
            sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
            echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
            sudo apt update
            sudo apt install -y kubectl
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing kubectl on $OS..."
            cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
            sudo yum install -y kubectl
            ;;
        *)
            echo "Installing kubectl using direct download method..."
            curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
            sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
            rm kubectl
            ;;
    esac

    # Verify installation
    if command_exists kubectl; then
        echo "kubectl has been successfully installed."
        kubectl version --client
    else
        echo "Failed to install kubectl. Please try installing it manually."
        return 1
    fi

    echo "kubectl installation completed."
    echo "You can now use kubectl to interact with Kubernetes clusters."
    echo "To get started, you may need to set up your kubeconfig file."
}

# Run the installation
install_kubectl