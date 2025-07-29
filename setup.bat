@echo off
echo ========================================
echo PHP Payroll v13 - Installation Script
echo ========================================
echo.

echo Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed!
    echo Please download and install Node.js from https://nodejs.org
    echo Choose the LTS version and restart this script after installation.
    pause
    exit /b 1
)

echo Node.js found! Version:
node --version

echo.
echo Checking npm installation...
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: npm is not installed!
    echo npm should come with Node.js. Please reinstall Node.js.
    pause
    exit /b 1
)

echo npm found! Version:
npm --version

echo.
echo ========================================
echo Installing PHP Payroll v13 Dependencies
echo ========================================
echo This may take a few minutes...
echo.

npm install

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to install dependencies!
    echo Please check your internet connection and try again.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Installation Complete!
echo ========================================
echo.
echo To start the PHP Payroll v13 system:
echo 1. Run: npm run dev
echo 2. Open your browser to: http://localhost:3000
echo.
echo For production use, run: npm run build && npm start
echo.
echo See INSTALLATION_MANUAL.md for detailed instructions.
echo.
pause
