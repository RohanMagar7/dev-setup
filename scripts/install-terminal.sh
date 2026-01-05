#!/bin/bash

################################################################################
# Install Terminal Tools
# Zsh, Oh-My-Zsh, Tmux
################################################################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

install_zsh() {
    log_info "Installing Zsh..."
    sudo apt update
    sudo apt install -y zsh
    log_success "Zsh installed: $(zsh --version)"
}

install_oh_my_zsh() {
    log_info "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Install plugins
    log_info "Installing Zsh plugins..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || true
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || true
    
    log_success "Oh-My-Zsh installed"
}

install_tmux() {
    log_info "Installing Tmux..."
    sudo apt install -y tmux
    log_success "Tmux installed: $(tmux -V)"
}

main() {
    echo "Installing Terminal Tools..."
    install_zsh
    install_oh_my_zsh
    install_tmux
    log_success "All terminal tools installed!"
    log_info "To set Zsh as default shell, run: chsh -s \$(which zsh)"
}

main
