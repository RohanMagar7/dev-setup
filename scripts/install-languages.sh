#!/bin/bash

################################################################################
# Install Programming Languages
# Python, Node.js, Go, Java
################################################################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Install Python
install_python() {
    log_info "Installing Python..."
    sudo apt update
    sudo apt install -y python3 python3-pip python3-venv python3-dev
    pip3 install --user --upgrade pip
    pip3 install --user virtualenv requests flask django numpy pandas pytest
    log_success "Python installed: $(python3 --version)"
}

# Install Node.js via NVM
install_nodejs() {
    log_info "Installing Node.js via NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
    npm install -g yarn typescript nodemon pm2
    log_success "Node.js installed: $(node --version)"
}

# Install Go
install_go() {
    log_info "Installing Go..."
    GO_VERSION="1.21.6"
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    rm go${GO_VERSION}.linux-amd64.tar.gz
    
    if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
        echo 'export GOPATH=$HOME/go' >> ~/.bashrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    fi
    
    export PATH=$PATH:/usr/local/go/bin
    log_success "Go installed: $(go version)"
}

# Install Java
install_java() {
    log_info "Installing Java..."
    sudo apt update
    sudo apt install -y openjdk-17-jdk openjdk-17-jre
    log_success "Java installed: $(java -version 2>&1 | head -1)"
}

main() {
    echo "Installing Programming Languages..."
    install_python
    install_nodejs
    install_go
    install_java
    log_success "All programming languages installed!"
}

main
