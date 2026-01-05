# Full Dev Setup for Ubuntu 🚀

A comprehensive, automated development environment setup for Ubuntu systems. This repository provides scripts and configurations to quickly set up a complete development environment with all essential tools, languages, databases, and utilities.

## 🎯 Features

This setup includes:

- **Essential Development Tools**: Git, Curl, Wget, Build-essential, etc.
- **Programming Languages**: Python, Node.js, Go, Java (OpenJDK)
- **Version Control**: Git with enhanced configuration
- **Text Editors & IDEs**: Visual Studio Code, Vim with plugins
- **Databases**: PostgreSQL, MySQL, MongoDB, Redis
- **Containerization**: Docker, Docker Compose
- **Cloud CLIs**: AWS CLI, Google Cloud SDK, Azure CLI
- **Terminal Tools**: Zsh, Oh-My-Zsh, Tmux
- **Additional Tools**: Postman, Slack, Chrome, Firefox

## 🚀 Quick Start

### One-Command Installation

```bash
curl -fsSL https://raw.githubusercontent.com/RohanMagar7/Full-Dev-Setup-Ubuntu-/main/setup.sh | bash
```

### Manual Installation

1. Clone this repository:
```bash
git clone https://github.com/RohanMagar7/Full-Dev-Setup-Ubuntu-.git
cd Full-Dev-Setup-Ubuntu-
```

2. Make the setup script executable:
```bash
chmod +x setup.sh
```

3. Run the setup script:
```bash
./setup.sh
```

## 📋 Prerequisites

- Ubuntu 20.04 LTS or later (tested on Ubuntu 20.04, 22.04, and 24.04)
- Sudo privileges
- Internet connection
- At least 10GB of free disk space

## 🔧 What Gets Installed

### System Tools
- build-essential (gcc, g++, make)
- curl, wget, apt-transport-https
- software-properties-common
- ca-certificates
- gnupg, lsb-release

### Programming Languages

#### Python
- Python 3 (latest)
- pip3
- virtualenv
- Common packages: requests, flask, django, numpy, pandas

#### Node.js
- Node.js (LTS version via NVM)
- npm (latest)
- Global packages: yarn, typescript, nodemon, pm2

#### Go
- Latest stable version of Go

#### Java
- OpenJDK 17

### Development Tools

#### Git
- Latest Git version
- Configured with helpful aliases
- Git LFS (Large File Storage)

#### Docker
- Docker Engine (latest)
- Docker Compose (latest)
- User added to docker group (no sudo required)

#### Visual Studio Code
- Latest stable version
- Popular extensions can be configured

### Databases

#### PostgreSQL
- Latest stable version
- Configured and running

#### MySQL
- Latest stable version
- Secured installation

#### MongoDB
- Latest stable version
- Configured and running

#### Redis
- Latest stable version
- Configured and running

### Terminal Enhancement

#### Zsh
- Zsh shell
- Oh-My-Zsh framework
- Powerlevel10k theme
- Useful plugins: git, docker, kubectl, zsh-autosuggestions, zsh-syntax-highlighting

### Cloud CLIs

- **AWS CLI**: Version 2
- **Google Cloud SDK**: Latest with gcloud
- **Azure CLI**: Latest

## 🎨 Customization

### Selective Installation

You can choose to install only specific components by using the modular scripts:

```bash
# Install only programming languages
./scripts/install-languages.sh

# Install only databases
./scripts/install-databases.sh

# Install only Docker
./scripts/install-docker.sh

# Install only terminal tools
./scripts/install-terminal.sh
```

### Configuration

After installation, you can customize configurations:

- **Git**: Edit `~/.gitconfig`
- **Zsh**: Edit `~/.zshrc`
- **Vim**: Edit `~/.vimrc`
- **Tmux**: Edit `~/.tmux.conf`

## 📚 Post-Installation

### Verify Installations

```bash
# Check versions
git --version
python3 --version
node --version
go version
java -version
docker --version
psql --version
mysql --version
mongod --version
redis-cli --version
```

### Start Services

```bash
# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Start PostgreSQL
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Start MySQL
sudo systemctl start mysql
sudo systemctl enable mysql

# Start MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod

# Start Redis
sudo systemctl start redis-server
sudo systemctl enable redis-server
```

## 🔍 Troubleshooting

### Common Issues

**Issue**: Docker permission denied
```bash
# Solution: Add user to docker group and re-login
sudo usermod -aG docker $USER
newgrp docker
```

**Issue**: Node.js command not found after NVM installation
```bash
# Solution: Source NVM in current shell
source ~/.nvm/nvm.sh
```

**Issue**: Oh-My-Zsh not loading
```bash
# Solution: Change default shell to zsh
chsh -s $(which zsh)
# Then log out and log back in
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

This script installs various packages and modifies system configurations. Always review scripts before running them. Use at your own risk.

## 🙏 Acknowledgments

- Ubuntu Community
- Oh-My-Zsh Community
- All the amazing open-source projects included in this setup

## 📧 Contact

For issues, questions, or suggestions, please open an issue on GitHub.

---

**Happy Coding! 🎉**