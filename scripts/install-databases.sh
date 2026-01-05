#!/bin/bash

################################################################################
# Install Databases
# PostgreSQL, MySQL, MongoDB, Redis
################################################################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Install PostgreSQL
install_postgresql() {
    log_info "Installing PostgreSQL..."
    sudo apt update
    sudo apt install -y postgresql postgresql-contrib
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
    log_success "PostgreSQL installed: $(psql --version)"
}

# Install MySQL
install_mysql() {
    log_info "Installing MySQL..."
    sudo apt install -y mysql-server
    sudo systemctl start mysql
    sudo systemctl enable mysql
    log_success "MySQL installed: $(mysql --version)"
}

# Install MongoDB
install_mongodb() {
    log_info "Installing MongoDB..."
    
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
        sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
    
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/7.0 multiverse" | \
        sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    
    sudo apt update
    sudo apt install -y mongodb-org
    sudo systemctl start mongod
    sudo systemctl enable mongod
    
    log_success "MongoDB installed: $(mongod --version | head -1)"
}

# Install Redis
install_redis() {
    log_info "Installing Redis..."
    sudo apt install -y redis-server
    sudo systemctl start redis-server
    sudo systemctl enable redis-server
    log_success "Redis installed: $(redis-cli --version)"
}

main() {
    echo "Installing Databases..."
    install_postgresql
    install_mysql
    install_mongodb
    install_redis
    log_success "All databases installed!"
}

main
