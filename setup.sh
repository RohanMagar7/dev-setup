#!/bin/bash

################################################################################
# Full Dev Setup for Ubuntu
# 
# This script automates the installation of a complete development environment
# for Ubuntu systems including languages, tools, databases, and utilities.
#
# Usage: ./setup.sh
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Ubuntu
check_ubuntu() {
    if [[ ! -f /etc/os-release ]]; then
        log_error "Cannot detect OS. This script is designed for Ubuntu."
        exit 1
    fi
    
    . /etc/os-release
    if [[ "$ID" != "ubuntu" ]]; then
        log_error "This script is designed for Ubuntu. Detected: $ID"
        exit 1
    fi
    
    log_success "Detected Ubuntu $VERSION"
}

# Check if running with sudo privileges
check_sudo() {
    if [[ $EUID -eq 0 ]]; then
        log_warning "This script should not be run as root. Run as regular user with sudo privileges."
        exit 1
    fi
    
    if ! sudo -v; then
        log_error "Sudo privileges required. Please run as a user with sudo access."
        exit 1
    fi
    
    log_success "Sudo privileges confirmed"
}

# Update system
update_system() {
    log_info "Updating system packages..."
    sudo apt update
    sudo apt upgrade -y
    log_success "System updated"
}

# Install essential tools
install_essentials() {
    log_info "Installing essential development tools..."
    sudo apt install -y \
        build-essential \
        curl \
        wget \
        git \
        vim \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release \
        software-properties-common \
        unzip \
        zip \
        tree \
        htop \
        net-tools
    log_success "Essential tools installed"
}

# Install Python
install_python() {
    log_info "Installing Python and pip..."
    sudo apt install -y python3 python3-pip python3-venv python3-dev
    
    # Install common Python packages
    pip3 install --user --upgrade pip
    pip3 install --user virtualenv requests flask django numpy pandas pytest
    
    log_success "Python installed"
    python3 --version
}

# Install Node.js via NVM
install_nodejs() {
    log_info "Installing Node.js via NVM..."
    
    # Install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    
    # Load NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Install Node.js LTS
    nvm install --lts
    nvm use --lts
    
    # Install global packages
    npm install -g yarn typescript nodemon pm2
    
    log_success "Node.js installed"
    node --version
    npm --version
}

# Install Go
install_go() {
    log_info "Installing Go..."
    
    GO_VERSION="1.21.6"
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    rm go${GO_VERSION}.linux-amd64.tar.gz
    
    # Add to PATH
    if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
        echo 'export GOPATH=$HOME/go' >> ~/.bashrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    fi
    
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=$HOME/go
    
    log_success "Go installed"
    go version
}

# Install Java
install_java() {
    log_info "Installing Java (OpenJDK)..."
    sudo apt install -y openjdk-17-jdk openjdk-17-jre
    log_success "Java installed"
    java -version
}

# Install Docker
install_docker() {
    log_info "Installing Docker..."
    
    # Remove old versions
    sudo apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
    
    # Add Docker's official GPG key
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    
    # Set up repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Install Docker
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    # Add user to docker group
    sudo usermod -aG docker $USER
    
    log_success "Docker installed"
    sudo docker --version
}

# Install PostgreSQL
install_postgresql() {
    log_info "Installing PostgreSQL..."
    sudo apt install -y postgresql postgresql-contrib
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
    log_success "PostgreSQL installed"
    psql --version
}

# Install MySQL
install_mysql() {
    log_info "Installing MySQL..."
    sudo apt install -y mysql-server
    sudo systemctl start mysql
    sudo systemctl enable mysql
    log_success "MySQL installed"
    mysql --version
}

# Install MongoDB
install_mongodb() {
    log_info "Installing MongoDB..."
    
    # Import MongoDB GPG key
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
        sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
    
    # Add MongoDB repository
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/7.0 multiverse" | \
        sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    
    # Install MongoDB
    sudo apt update
    sudo apt install -y mongodb-org
    sudo systemctl start mongod
    sudo systemctl enable mongod
    
    log_success "MongoDB installed"
    mongod --version
}

# Install Redis
install_redis() {
    log_info "Installing Redis..."
    sudo apt install -y redis-server
    sudo systemctl start redis-server
    sudo systemctl enable redis-server
    log_success "Redis installed"
    redis-cli --version
}

# Install VS Code
install_vscode() {
    log_info "Installing Visual Studio Code..."
    
    # Download and install Microsoft GPG key
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    rm packages.microsoft.gpg
    
    # Add VS Code repository
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
        sudo tee /etc/apt/sources.list.d/vscode.list
    
    # Install VS Code
    sudo apt update
    sudo apt install -y code
    
    log_success "Visual Studio Code installed"
}

# Install Zsh and Oh-My-Zsh
install_zsh() {
    log_info "Installing Zsh and Oh-My-Zsh..."
    
    # Install Zsh
    sudo apt install -y zsh
    
    # Install Oh-My-Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Install zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || true
    
    # Install zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || true
    
    log_success "Zsh and Oh-My-Zsh installed"
}

# Install AWS CLI
install_aws_cli() {
    log_info "Installing AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    log_success "AWS CLI installed"
    aws --version
}

# Install Google Cloud SDK
install_gcloud() {
    log_info "Installing Google Cloud SDK..."
    
    # Add the Cloud SDK distribution URI as a package source
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
        sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    
    # Import the Google Cloud public key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
        sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    
    # Install the Cloud SDK
    sudo apt update
    sudo apt install -y google-cloud-cli
    
    log_success "Google Cloud SDK installed"
}

# Install Azure CLI
install_azure_cli() {
    log_info "Installing Azure CLI..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    log_success "Azure CLI installed"
    az --version
}

# Configure Git
configure_git() {
    log_info "Configuring Git..."
    
    # Only set if not already configured
    if [[ -z "$(git config --global user.name)" ]]; then
        read -p "Enter your Git username: " git_username
        git config --global user.name "$git_username"
    fi
    
    if [[ -z "$(git config --global user.email)" ]]; then
        read -p "Enter your Git email: " git_email
        git config --global user.email "$git_email"
    fi
    
    # Set useful Git aliases
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.unstage 'reset HEAD --'
    
    log_success "Git configured"
}

# Main installation function
main() {
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                                                                ║"
    echo "║         Full Dev Setup for Ubuntu                              ║"
    echo "║                                                                ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    
    check_ubuntu
    check_sudo
    
    echo ""
    log_info "Starting full development environment setup..."
    echo ""
    
    # Update system first
    update_system
    
    # Install components
    install_essentials
    install_python
    install_nodejs
    install_go
    install_java
    install_docker
    install_postgresql
    install_mysql
    install_mongodb
    install_redis
    install_vscode
    install_zsh
    install_aws_cli
    install_gcloud
    install_azure_cli
    configure_git
    
    echo ""
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                                                                ║"
    echo "║         Installation Complete! 🎉                              ║"
    echo "║                                                                ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    log_success "All components installed successfully!"
    echo ""
    log_info "IMPORTANT: Please log out and log back in for all changes to take effect."
    log_info "To use Zsh as default shell, run: chsh -s \$(which zsh)"
    log_info "To use Docker without sudo, log out and log back in."
    echo ""
}

# Run main function
main
