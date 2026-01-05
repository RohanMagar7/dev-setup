#!/bin/bash

set -e

echo "=============================="
echo " Full Development Setup Start "
echo "=============================="

# 1. Update system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# 2. Essential build tools
echo "Installing build essentials..."
sudo apt install -y build-essential gcc g++ make cmake \
git curl wget unzip zip software-properties-common

# 3. Python development
echo "Installing Python development tools..."
sudo apt install -y python3 python3-pip python3-venv python3-dev

pip3 install --user virtualenv pipenv pylint black

# 4. Java JDK
echo "Installing OpenJDK 17..."
sudo apt install -y openjdk-17-jdk

# 5. Node.js & JavaScript
echo "Installing Node.js 20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

sudo npm install -g yarn nodemon eslint

# 6. Databases
echo "Installing databases..."
sudo apt install -y mysql-server
sudo apt install -y postgresql postgresql-contrib
sudo apt install -y sqlite3

# 7. VS Code
echo "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Optional editors
sudo apt install -y vim nano

# 8. Docker
echo "Installing Docker..."
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# 9. Web stack
echo "Installing web stack..."
sudo apt install -y apache2 nginx php php-cli php-mysql php-curl php-mbstring php-xml

# 10. Debugging & system tools
echo "Installing debugging tools..."
sudo apt install -y gdb valgrind strace htop tree neofetch

# 11. Git LFS
echo "Installing Git LFS..."
sudo apt install -y git-lfs
git lfs install

echo "=============================="
echo " INSTALLATION COMPLETE ✅"
echo "=============================="
echo "⚠️ Please LOG OUT & LOG IN again for Docker to work"
