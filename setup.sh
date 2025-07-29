#!/bin/bash

echo "========================================"
echo "PHP Payroll v13 - Installation Script"
echo "========================================"
echo

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js is not installed!"
    echo "Please install Node.js first:"
    echo
    echo "For Ubuntu/Debian:"
    echo "curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -"
    echo "sudo apt-get install -y nodejs"
    echo
    echo "For macOS with Homebrew:"
    echo "brew install node"
    echo
    echo "Or download from: https://nodejs.org"
    exit 1
fi

echo "Node.js found! Version:"
node --version

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "ERROR: npm is not installed!"
    echo "npm should come with Node.js. Please reinstall Node.js."
    exit 1
fi

echo "npm found! Version:"
npm --version

echo
echo "========================================"
echo "Installing PHP Payroll v13 Dependencies"
echo "========================================"
echo "This may take a few minutes..."
echo

# Install dependencies
npm install

if [ $? -ne 0 ]; then
    echo
    echo "ERROR: Failed to install dependencies!"
    echo "Please check your internet connection and try again."
    exit 1
fi

echo
echo "========================================"
echo "Installation Complete!"
echo "========================================"
echo
echo "To start the PHP Payroll v13 system:"
echo "1. Run: npm run dev"
echo "2. Open your browser to: http://localhost:3000"
echo
echo "For production use, run: npm run build && npm start"
echo
echo "See INSTALLATION_MANUAL.md for detailed instructions."
echo

# Make the script executable
chmod +x setup.sh
