#!/bin/bash

################################################################################
# Verify Full Dev Setup Installation
# 
# This script checks if all components are properly installed
################################################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

passed=0
failed=0

check_command() {
    local name=$1
    local command=$2
    
    if command -v $command &> /dev/null; then
        echo -e "${GREEN}✓${NC} $name: $(command -v $command)"
        ((passed++))
        return 0
    else
        echo -e "${RED}✗${NC} $name: Not found"
        ((failed++))
        return 1
    fi
}

check_version() {
    local name=$1
    local command=$2
    
    if eval $command &> /dev/null; then
        version=$(eval $command 2>&1)
        echo -e "${GREEN}✓${NC} $name: $version"
        ((passed++))
        return 0
    else
        echo -e "${RED}✗${NC} $name: Not installed or not working"
        ((failed++))
        return 1
    fi
}

check_service() {
    local name=$1
    local service=$2
    
    if systemctl is-active --quiet $service; then
        echo -e "${GREEN}✓${NC} $name: Running"
        ((passed++))
        return 0
    else
        echo -e "${YELLOW}!${NC} $name: Not running (may need to start)"
        return 1
    fi
}

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║         Verifying Full Dev Setup Installation                  ║"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

echo -e "${BLUE}System Information:${NC}"
echo "OS: $(lsb_release -d | cut -f2)"
echo "Kernel: $(uname -r)"
echo ""

echo -e "${BLUE}Essential Tools:${NC}"
check_command "Git" "git"
check_command "Curl" "curl"
check_command "Wget" "wget"
check_command "Vim" "vim"
check_command "Build Essential" "gcc"
echo ""

echo -e "${BLUE}Programming Languages:${NC}"
check_version "Python" "python3 --version"
check_version "pip" "pip3 --version"
check_version "Node.js" "node --version"
check_version "npm" "npm --version"
check_version "Go" "go version"
check_version "Java" "java -version 2>&1 | head -1"
echo ""

echo -e "${BLUE}Development Tools:${NC}"
check_command "Docker" "docker"
check_command "Docker Compose" "docker"
check_command "Visual Studio Code" "code"
echo ""

echo -e "${BLUE}Databases:${NC}"
check_command "PostgreSQL" "psql"
check_command "MySQL" "mysql"
check_command "MongoDB" "mongod"
check_command "Redis" "redis-cli"
echo ""

echo -e "${BLUE}Database Services:${NC}"
check_service "PostgreSQL" "postgresql"
check_service "MySQL" "mysql"
check_service "MongoDB" "mongod"
check_service "Redis" "redis-server"
echo ""

echo -e "${BLUE}Terminal Tools:${NC}"
check_command "Zsh" "zsh"
check_command "Tmux" "tmux"
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${GREEN}✓${NC} Oh-My-Zsh: Installed"
    ((passed++))
else
    echo -e "${RED}✗${NC} Oh-My-Zsh: Not installed"
    ((failed++))
fi
echo ""

echo -e "${BLUE}Cloud CLIs:${NC}"
check_command "AWS CLI" "aws"
check_command "Google Cloud SDK" "gcloud"
check_command "Azure CLI" "az"
echo ""

echo -e "${BLUE}NVM (Node Version Manager):${NC}"
if [ -d "$HOME/.nvm" ]; then
    echo -e "${GREEN}✓${NC} NVM: Installed at $HOME/.nvm"
    ((passed++))
else
    echo -e "${YELLOW}!${NC} NVM: Not found"
fi
echo ""

echo "════════════════════════════════════════════════════════════════"
total=$((passed + failed))
percentage=$((passed * 100 / total))

echo -e "Results: ${GREEN}$passed passed${NC}, ${RED}$failed failed${NC} out of $total checks"
echo -e "Success Rate: $percentage%"

if [ $failed -eq 0 ]; then
    echo -e "${GREEN}All checks passed! ✓${NC}"
    exit 0
elif [ $passed -gt $failed ]; then
    echo -e "${YELLOW}Most checks passed, but some components are missing or not running.${NC}"
    exit 1
else
    echo -e "${RED}Many checks failed. Please review the installation.${NC}"
    exit 1
fi
