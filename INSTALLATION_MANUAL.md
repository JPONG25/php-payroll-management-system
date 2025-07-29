# PHP Payroll v13 - Installation Manual

## Complete Installation Guide for Modern Web-Based Payroll System with QR Code Attendance

---

## Table of Contents
1. [System Requirements](#system-requirements)
2. [Installation Steps](#installation-steps)
3. [Configuration](#configuration)
4. [Running the Application](#running-the-application)
5. [Deployment Options](#deployment-options)
6. [Troubleshooting](#troubleshooting)
7. [System Features](#system-features)
8. [Support](#support)

---

## System Requirements

### Minimum Requirements:
- **Operating System**: Windows 10/11, macOS 10.15+, or Linux (Ubuntu 18.04+)
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 2GB free space
- **Internet Connection**: Required for initial setup and dependencies

### Software Requirements:
- **Node.js**: Version 18.0 or higher
- **npm**: Version 8.0 or higher (comes with Node.js)
- **Web Browser**: Chrome, Firefox, Safari, or Edge (latest versions)

---

## Installation Steps

### Step 1: Install Node.js

#### For Windows:
1. Download Node.js from [https://nodejs.org](https://nodejs.org)
2. Choose "LTS" version (recommended)
3. Run the installer and follow the setup wizard
4. Restart your computer after installation

#### For macOS:
1. Download Node.js from [https://nodejs.org](https://nodejs.org)
2. Run the `.pkg` installer
3. Or use Homebrew: `brew install node`

#### For Linux (Ubuntu/Debian):
```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

#### Verify Installation:
Open terminal/command prompt and run:
```bash
node --version
npm --version
```

### Step 2: Download the System

#### Option A: Download ZIP File
1. Download the system files as a ZIP archive
2. Extract to your desired location (e.g., `C:\PayrollSystem` or `/home/user/PayrollSystem`)

#### Option B: Clone from Repository (if available)
```bash
git clone [repository-url] PayrollSystem
cd PayrollSystem
```

### Step 3: Install Dependencies

1. Open terminal/command prompt
2. Navigate to the project directory:
```bash
cd PayrollSystem
```

3. Install all required dependencies:
```bash
npm install
```

This will install all necessary packages including:
- Next.js framework
- React components
- UI libraries (shadcn/ui)
- Tailwind CSS
- TypeScript support

### Step 4: Initial Setup

1. Copy environment configuration:
```bash
cp .env.example .env.local
```

2. Edit the `.env.local` file with your settings:
```env
# Application Settings
NEXT_PUBLIC_APP_NAME="PHP Payroll v13"
NEXT_PUBLIC_APP_VERSION="13.0"

# Database Configuration (if using external database)
# DATABASE_URL="your-database-connection-string"

# API Keys (if needed for external services)
# OPENAI_API_KEY="your-api-key"
# REPLICATE_API_TOKEN="your-replicate-token"
```

---

## Configuration

### Company Information Setup

1. Start the application (see Running section below)
2. Navigate to **Settings** → **General**
3. Update company information:
   - Company Name
   - Address
   - Phone Number
   - Email
   - TIN Number

### Tax Configuration

1. Go to **Settings** → **Tax Settings**
2. Configure Philippines tax rates:
   - SSS Contribution rates
   - PhilHealth Premium rates
   - Pag-IBIG Contribution rates
   - Withholding Tax settings

### Employee Setup

1. Navigate to **Employees** tab
2. Click **Add New Employee**
3. Fill in employee information:
   - Personal details
   - Employment information
   - Salary structure

### QR Code Setup

1. Go to **Attendance** → **QR Codes**
2. Generate QR codes for each employee
3. Print or download QR codes for distribution

---

## Running the Application

### Development Mode (for testing):
```bash
npm run dev
```
The application will be available at: `http://localhost:3000`

### Production Mode:
```bash
# Build the application
npm run build

# Start production server
npm start
```

### Custom Port:
To run on a different port (e.g., port 8000):
```bash
PORT=8000 npm run dev
```

---

## Deployment Options

### Option 1: Local Network Deployment

1. Build the application:
```bash
npm run build
```

2. Start the production server:
```bash
npm start
```

3. Access from other computers using your IP address:
   - Find your IP: `ipconfig` (Windows) or `ifconfig` (Mac/Linux)
   - Access via: `http://[YOUR-IP]:3000`

### Option 2: Cloud Deployment

#### Vercel (Recommended):
1. Install Vercel CLI:
```bash
npm install -g vercel
```

2. Deploy:
```bash
vercel
```

#### Netlify:
1. Build the application:
```bash
npm run build
```

2. Upload the `out` folder to Netlify

#### Other Hosting Providers:
- AWS EC2
- Google Cloud Platform
- DigitalOcean
- Heroku

### Option 3: Windows Service (for permanent installation)

1. Install PM2 globally:
```bash
npm install -g pm2
```

2. Create ecosystem file (`ecosystem.config.js`):
```javascript
module.exports = {
  apps: [{
    name: 'payroll-system',
    script: 'npm',
    args: 'start',
    cwd: './PayrollSystem',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    }
  }]
}
```

3. Start the service:
```bash
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

---

## System Features

### Core Modules:
1. **Dashboard** - Overview and key metrics
2. **Employee Management** - Complete employee database
3. **QR Code Attendance** - Modern attendance tracking
4. **Payroll Calculation** - Automated salary processing
5. **Payslip Generation** - Professional payslip creation
6. **Reports & Analytics** - Comprehensive reporting
7. **System Settings** - Configuration and data migration

### Key Features:
- ✅ Philippines Tax Compliance (BIR, SSS, PhilHealth, Pag-IBIG)
- ✅ QR Code-based Attendance System
- ✅ Automated Payroll Calculations
- ✅ Professional Payslip Generation
- ✅ Multi-period Payroll Cycles
- ✅ Loan Management
- ✅ Leave Tracking
- ✅ Data Migration Support
- ✅ Responsive Design (Mobile/Desktop)
- ✅ Modern UI with Dark/Light Mode

---

## Troubleshooting

### Common Issues:

#### 1. "npm command not found"
**Solution**: Install Node.js properly and restart terminal

#### 2. "Port already in use"
**Solution**: 
```bash
# Kill process on port 3000
npx kill-port 3000
# Or use different port
PORT=8000 npm run dev
```

#### 3. "Module not found" errors
**Solution**: 
```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
```

#### 4. "Permission denied" (Linux/Mac)
**Solution**: 
```bash
sudo chown -R $(whoami) ~/.npm
```

#### 5. Application won't start
**Solution**: 
```bash
# Check Node.js version
node --version
# Should be 18.0 or higher

# Clear Next.js cache
rm -rf .next
npm run build
```

### Performance Optimization:

1. **For better performance**:
```bash
# Enable production optimizations
NODE_ENV=production npm start
```

2. **For large companies (500+ employees)**:
   - Consider using external database
   - Implement caching
   - Use CDN for static assets

---

## Network Access Setup

### Allow Access from Other Computers:

1. **Windows Firewall**:
   - Open Windows Defender Firewall
   - Click "Allow an app through firewall"
   - Add Node.js or allow port 3000

2. **Router Configuration**:
   - Access router admin panel
   - Forward port 3000 to your computer's IP
   - Enable port forwarding

3. **Find Your IP Address**:
   - Windows: `ipconfig`
   - Mac/Linux: `ifconfig`
   - Access via: `http://[YOUR-IP]:3000`

---

## Backup and Data Management

### Regular Backups:
1. **Automatic Backups**: Go to Settings → Backup
2. **Manual Backup**: Export data regularly
3. **Database Backup**: If using external database

### Data Migration:
1. Go to **Settings** → **Migration**
2. Follow the step-by-step migration process
3. Validate data integrity after migration

---

## Security Considerations

### Basic Security:
1. Change default passwords
2. Use HTTPS in production
3. Regular system updates
4. Backup data regularly

### Network Security:
1. Use VPN for remote access
2. Implement user authentication
3. Regular security audits
4. Monitor access logs

---

## Support and Maintenance

### Regular Maintenance:
1. **Weekly**: Check system performance
2. **Monthly**: Update dependencies
3. **Quarterly**: Full system backup
4. **Annually**: Security audit

### Getting Help:
1. Check this manual first
2. Review error logs in terminal
3. Check system requirements
4. Contact technical support

### System Updates:
```bash
# Update dependencies
npm update

# Check for security vulnerabilities
npm audit
npm audit fix
```

---

## Quick Start Checklist

- [ ] Install Node.js (version 18+)
- [ ] Download/extract system files
- [ ] Run `npm install`
- [ ] Configure company settings
- [ ] Add employees
- [ ] Generate QR codes
- [ ] Test payroll calculation
- [ ] Setup network access (if needed)
- [ ] Create regular backup schedule

---

## Technical Specifications

- **Framework**: Next.js 15.3.2
- **Frontend**: React 19 with TypeScript
- **UI Library**: shadcn/ui with Tailwind CSS
- **Charts**: Recharts for analytics
- **Forms**: React Hook Form with Zod validation
- **Icons**: No external dependencies (typography-based design)
- **Responsive**: Mobile and desktop optimized

---

## License and Compliance

This system is designed to be compliant with:
- Philippines Bureau of Internal Revenue (BIR) regulations
- Social Security System (SSS) requirements
- PhilHealth premium calculations
- Pag-IBIG contribution rules
- Labor Code of the Philippines

---

**PHP Payroll v13 - Modern Payroll Management System**
*Complete solution for automated salary calculations, tax compliance, and QR code-based attendance tracking*

For technical support or questions, please refer to the troubleshooting section or contact your system administrator.
