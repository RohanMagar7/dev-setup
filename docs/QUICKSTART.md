# Quick Start Guide

This guide will help you get started with Full Dev Setup Ubuntu quickly.

## Installation

### Option 1: One-Command Installation (Recommended)

The fastest way to set up your development environment:

```bash
curl -fsSL https://raw.githubusercontent.com/RohanMagar7/Full-Dev-Setup-Ubuntu-/main/setup.sh | bash
```

### Option 2: Clone and Run

For more control over the installation:

```bash
# Clone the repository
git clone https://github.com/RohanMagar7/Full-Dev-Setup-Ubuntu-.git
cd Full-Dev-Setup-Ubuntu-

# Make script executable
chmod +x setup.sh

# Run the setup
./setup.sh
```

### Option 3: Selective Installation

Install only what you need:

```bash
# Clone the repository
git clone https://github.com/RohanMagar7/Full-Dev-Setup-Ubuntu-.git
cd Full-Dev-Setup-Ubuntu-

# Make scripts executable
chmod +x scripts/*.sh

# Install only programming languages
./scripts/install-languages.sh

# Install only databases
./scripts/install-databases.sh

# Install only Docker
./scripts/install-docker.sh

# Install only terminal tools
./scripts/install-terminal.sh
```

## What You'll Get

After installation, you'll have:

### Programming Languages
- Python 3 with pip
- Node.js (LTS) with npm
- Go (latest stable)
- Java (OpenJDK 17)

### Development Tools
- Git with helpful configuration
- Docker and Docker Compose
- Visual Studio Code

### Databases
- PostgreSQL
- MySQL
- MongoDB
- Redis

### Terminal Tools
- Zsh with Oh-My-Zsh
- Useful plugins and themes
- Tmux

### Cloud CLIs
- AWS CLI
- Google Cloud SDK
- Azure CLI

## Post-Installation Steps

### 1. Restart Your Terminal

After installation, close and reopen your terminal to apply all changes.

### 2. Verify Installations

Check that everything is installed correctly:

```bash
# Programming languages
python3 --version
node --version
go version
java -version

# Tools
git --version
docker --version

# Databases
psql --version
mysql --version
mongod --version
redis-cli --version

# Cloud CLIs
aws --version
gcloud --version
az --version
```

### 3. Set Default Shell (Optional)

To use Zsh as your default shell:

```bash
chsh -s $(which zsh)
```

Log out and log back in for the change to take effect.

### 4. Configure Git

The script will prompt for your Git username and email. If you skipped this or want to update:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 5. Test Docker

Docker requires you to log out and log back in for group permissions:

```bash
# Test Docker
docker run hello-world

# If permission denied, log out and log back in
```

## First Steps

### Create Your First Project

#### Python Project

```bash
# Create project directory
mkdir my-python-project
cd my-python-project

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install packages
pip install flask

# Create app.py
cat > app.py << 'EOF'
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(debug=True)
EOF

# Run
python app.py
```

#### Node.js Project

```bash
# Create project directory
mkdir my-node-project
cd my-node-project

# Initialize project
npm init -y

# Install Express
npm install express

# Create app.js
cat > app.js << 'EOF'
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
EOF

# Run
node app.js
```

#### Go Project

```bash
# Create project directory
mkdir my-go-project
cd my-go-project

# Initialize module
go mod init example.com/hello

# Create main.go
cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
EOF

# Run
go run main.go

# Build
go build
```

### Working with Databases

#### PostgreSQL

```bash
# Connect to PostgreSQL
sudo -u postgres psql

# In psql:
CREATE DATABASE mydb;
CREATE USER myuser WITH PASSWORD 'mypassword';
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
\q

# Connect as your user
psql -U myuser -d mydb -h localhost
```

#### MySQL

```bash
# Connect to MySQL
sudo mysql

# In MySQL:
CREATE DATABASE mydb;
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# Connect as your user
mysql -u myuser -p
```

#### MongoDB

```bash
# Connect to MongoDB
mongosh

# In MongoDB shell:
use mydb
db.users.insertOne({name: "John", age: 30})
db.users.find()
```

#### Redis

```bash
# Connect to Redis
redis-cli

# Test commands
PING
SET mykey "Hello"
GET mykey
```

### Using Docker

```bash
# Pull an image
docker pull ubuntu

# Run a container
docker run -it ubuntu bash

# List containers
docker ps -a

# List images
docker images

# Docker Compose example
cat > docker-compose.yml << 'EOF'
version: '3'
services:
  web:
    image: nginx
    ports:
      - "8080:80"
EOF

docker compose up -d
```

## Customization

### Configure Zsh

Edit your Zsh configuration:

```bash
nano ~/.zshrc

# Change theme
ZSH_THEME="agnoster"

# Add/remove plugins
plugins=(git docker python node)

# Apply changes
source ~/.zshrc
```

### Configure Vim

Copy the template and customize:

```bash
cp configs/.vimrc.template ~/.vimrc
nano ~/.vimrc
```

### Configure Tmux

Copy the template and customize:

```bash
cp configs/.tmux.conf.template ~/.tmux.conf
tmux source ~/.tmux.conf
```

## Common Commands

### Development

```bash
# Create a new directory and cd into it
mkcd project-name

# Quick git status
gs

# Start VS Code
code .

# Update system
sudo apt update && sudo apt upgrade -y
```

### Docker

```bash
# Start/stop containers
docker compose up -d
docker compose down

# View logs
docker logs container-name

# Execute command in container
docker exec -it container-name bash
```

### Terminal Management

```bash
# Start tmux session
tmux

# Split panes
Ctrl+a |  # Vertical split
Ctrl+a -  # Horizontal split

# Navigate panes
Alt + Arrow Keys

# Detach from tmux
Ctrl+a d

# List sessions
tmux ls

# Attach to session
tmux attach
```

## Next Steps

1. **Explore VS Code**: Install extensions for your preferred languages
2. **Configure Cloud CLIs**: Set up AWS, GCloud, or Azure credentials
3. **Create Projects**: Start building with your new environment
4. **Customize**: Adjust configurations to your preferences
5. **Learn**: Explore the tools and their documentation

## Resources

- [Python Documentation](https://docs.python.org/)
- [Node.js Documentation](https://nodejs.org/docs/)
- [Go Documentation](https://golang.org/doc/)
- [Docker Documentation](https://docs.docker.com/)
- [Oh-My-Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh)

## Getting Help

- Check the [Troubleshooting Guide](docs/TROUBLESHOOTING.md)
- Review the [README](README.md)
- Open an [issue on GitHub](https://github.com/RohanMagar7/Full-Dev-Setup-Ubuntu-/issues)

---

**Happy Coding! 🚀**
