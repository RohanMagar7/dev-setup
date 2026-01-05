# Troubleshooting Guide

This guide helps you resolve common issues encountered during the Full Dev Setup for Ubuntu.

## Table of Contents

- [General Issues](#general-issues)
- [Installation Issues](#installation-issues)
- [Docker Issues](#docker-issues)
- [Node.js Issues](#nodejs-issues)
- [Database Issues](#database-issues)
- [Terminal Issues](#terminal-issues)
- [Git Issues](#git-issues)

## General Issues

### Script Fails Immediately

**Problem**: The setup script exits with an error right away.

**Solution**:
```bash
# Check if you have sudo privileges
sudo -v

# Update package list
sudo apt update

# Make sure script is executable
chmod +x setup.sh

# Check Ubuntu version (should be 20.04+)
lsb_release -a
```

### Insufficient Disk Space

**Problem**: Installation fails due to lack of disk space.

**Solution**:
```bash
# Check available disk space
df -h

# Clean up apt cache
sudo apt clean
sudo apt autoremove

# Remove old kernels
sudo apt autoremove --purge
```

### Network Issues

**Problem**: Downloads fail or timeout.

**Solution**:
```bash
# Test internet connectivity
ping -c 4 google.com

# Check DNS resolution
nslookup github.com

# Try using different DNS servers
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
```

## Installation Issues

### Package Installation Fails

**Problem**: A specific package fails to install.

**Solution**:
```bash
# Update package list
sudo apt update

# Fix broken packages
sudo apt --fix-broken install

# Reconfigure packages
sudo dpkg --configure -a

# Try installing the package individually
sudo apt install -y PACKAGE_NAME
```

### GPG Key Errors

**Problem**: GPG key verification fails for repositories.

**Solution**:
```bash
# For Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# For MongoDB
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

# Update and retry
sudo apt update
```

## Docker Issues

### Permission Denied

**Problem**: `docker: permission denied while trying to connect to the Docker daemon socket`

**Solution**:
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Apply changes (or log out and log back in)
newgrp docker

# Verify
docker ps
```

### Docker Service Not Running

**Problem**: Docker commands fail because the daemon is not running.

**Solution**:
```bash
# Start Docker service
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Check status
sudo systemctl status docker
```

### Docker Compose Not Found

**Problem**: `docker-compose: command not found`

**Solution**:
```bash
# Docker Compose is now a plugin (V2)
# Use: docker compose (not docker-compose)
docker compose version

# If still not found, reinstall
sudo apt install -y docker-compose-plugin
```

## Node.js Issues

### NVM Command Not Found

**Problem**: `nvm: command not found` after installation.

**Solution**:
```bash
# Source NVM in current shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Add to shell profile
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc

# Reload shell
source ~/.bashrc
```

### Node Version Issues

**Problem**: Wrong Node.js version is being used.

**Solution**:
```bash
# List installed versions
nvm list

# Install specific version
nvm install 18.19.0

# Use specific version
nvm use 18.19.0

# Set default version
nvm alias default 18.19.0
```

### npm Permission Errors

**Problem**: Permission denied when installing global packages.

**Solution**:
```bash
# Option 1: Install packages for user only
npm install -g --user PACKAGE_NAME

# Option 2: Fix npm permissions
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

## Database Issues

### PostgreSQL Connection Refused

**Problem**: Cannot connect to PostgreSQL.

**Solution**:
```bash
# Check if service is running
sudo systemctl status postgresql

# Start service
sudo systemctl start postgresql

# Connect as postgres user
sudo -u postgres psql

# Create your user
CREATE USER your_username WITH PASSWORD 'your_password';
CREATE DATABASE your_database;
GRANT ALL PRIVILEGES ON DATABASE your_database TO your_username;
```

### MySQL Access Denied

**Problem**: `Access denied for user 'root'@'localhost'`

**Solution**:
```bash
# Reset root password
sudo mysql

# In MySQL shell
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'new_password';
FLUSH PRIVILEGES;
EXIT;

# Test connection
mysql -u root -p
```

### MongoDB Not Starting

**Problem**: MongoDB service fails to start.

**Solution**:
```bash
# Check logs
sudo journalctl -u mongod -n 50

# Check configuration
sudo nano /etc/mongod.conf

# Fix permissions
sudo chown -R mongodb:mongodb /var/lib/mongodb
sudo chown -R mongodb:mongodb /var/log/mongodb

# Restart service
sudo systemctl restart mongod
```

### Redis Connection Issues

**Problem**: Cannot connect to Redis.

**Solution**:
```bash
# Check if running
sudo systemctl status redis-server

# Start service
sudo systemctl start redis-server

# Test connection
redis-cli ping
# Should return: PONG

# Check configuration
sudo nano /etc/redis/redis.conf
```

## Terminal Issues

### Oh-My-Zsh Not Loading

**Problem**: Zsh is installed but Oh-My-Zsh doesn't load.

**Solution**:
```bash
# Set Zsh as default shell
chsh -s $(which zsh)

# Log out and log back in

# If still not working, manually source
source ~/.zshrc

# Reinstall Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Zsh Plugins Not Working

**Problem**: Installed plugins are not active.

**Solution**:
```bash
# Edit .zshrc
nano ~/.zshrc

# Add plugins to the plugins array
plugins=(
    git
    docker
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Reload configuration
source ~/.zshrc
```

### Theme Not Displaying Correctly

**Problem**: Zsh theme shows weird characters.

**Solution**:
```bash
# Install Powerline fonts
sudo apt install -y fonts-powerline

# Or install Nerd Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip
unzip Meslo.zip
fc-cache -fv
```

## Git Issues

### Git User Not Configured

**Problem**: `Please tell me who you are` error when committing.

**Solution**:
```bash
# Configure Git user
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify
git config --list
```

### Git Credential Issues

**Problem**: Git keeps asking for credentials.

**Solution**:
```bash
# Use credential helper
git config --global credential.helper store

# Or use cache (timeout after 1 hour)
git config --global credential.helper 'cache --timeout=3600'

# For SSH keys
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub
# Add to GitHub/GitLab
```

## VS Code Issues

### VS Code Won't Start

**Problem**: Visual Studio Code doesn't launch.

**Solution**:
```bash
# Reinstall VS Code
sudo apt remove code
sudo apt install code

# Check if snap version conflicts
snap list | grep code
sudo snap remove code  # If found

# Start from terminal to see errors
code
```

### Extensions Not Installing

**Problem**: Cannot install VS Code extensions.

**Solution**:
```bash
# Clear extension cache
rm -rf ~/.vscode/extensions

# Restart VS Code
code --disable-extensions

# Check permissions
ls -la ~/.vscode/
```

## Cloud CLI Issues

### AWS CLI Not Found

**Problem**: `aws: command not found`

**Solution**:
```bash
# Verify installation
which aws

# Check PATH
echo $PATH

# Reinstall if needed
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update
```

### gcloud Command Not Found

**Problem**: `gcloud: command not found`

**Solution**:
```bash
# Add to PATH
echo 'export PATH=$PATH:/usr/lib/google-cloud-sdk/bin' >> ~/.bashrc
source ~/.bashrc

# Initialize gcloud
gcloud init
```

## Getting More Help

If your issue is not listed here:

1. Check the [GitHub Issues](https://github.com/RohanMagar7/Full-Dev-Setup-Ubuntu-/issues)
2. Search for similar problems online
3. Open a new issue with:
   - Detailed description of the problem
   - Error messages
   - Ubuntu version
   - Steps to reproduce

## Reporting Bugs

When reporting bugs, please include:

```bash
# System information
uname -a
lsb_release -a
cat /etc/os-release

# Package versions
apt list --installed | grep PACKAGE_NAME

# Service status (for relevant services)
systemctl status SERVICE_NAME

# Error logs
journalctl -u SERVICE_NAME -n 50
```

---

**Need More Help?** Open an issue on GitHub with detailed information about your problem.
