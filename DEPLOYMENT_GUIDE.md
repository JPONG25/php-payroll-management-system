# PHP Payroll v13 - Deployment Guide

## Complete Deployment Options for Different Environments

---

## Table of Contents
1. [Local Network Deployment](#local-network-deployment)
2. [Cloud Deployment](#cloud-deployment)
3. [Windows Server Deployment](#windows-server-deployment)
4. [Linux Server Deployment](#linux-server-deployment)
5. [Docker Deployment](#docker-deployment)
6. [Network Configuration](#network-configuration)
7. [Security Considerations](#security-considerations)

---

## Local Network Deployment

### For Small to Medium Businesses (Recommended)

#### Step 1: Prepare the Host Computer
```bash
# Install and setup
npm install
npm run build
```

#### Step 2: Configure for Network Access
1. Edit `next.config.ts`:
```typescript
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  experimental: {
    serverActions: {
      allowedOrigins: ['*']
    }
  }
}

export default nextConfig
```

#### Step 3: Start Production Server
```bash
# Start on all network interfaces
npm start
```

#### Step 4: Configure Windows Firewall
1. Open Windows Defender Firewall
2. Click "Allow an app or feature through Windows Defender Firewall"
3. Click "Change Settings" → "Allow another app"
4. Browse and select Node.js
5. Check both "Private" and "Public" networks

#### Step 5: Access from Other Computers
- Find host computer IP: `ipconfig`
- Access from other PCs: `http://[HOST-IP]:3000`

---

## Cloud Deployment

### Option 1: Vercel (Easiest)

#### Prerequisites:
- GitHub account
- Vercel account (free tier available)

#### Steps:
1. **Push to GitHub**:
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin [your-github-repo]
git push -u origin main
```

2. **Deploy to Vercel**:
   - Go to [vercel.com](https://vercel.com)
   - Connect GitHub account
   - Import your repository
   - Deploy automatically

3. **Custom Domain** (Optional):
   - Add your domain in Vercel dashboard
   - Update DNS settings

### Option 2: Netlify

#### Steps:
1. **Build for Static Export**:
```bash
npm run build
```

2. **Deploy to Netlify**:
   - Go to [netlify.com](https://netlify.com)
   - Drag and drop the `out` folder
   - Or connect GitHub repository

### Option 3: AWS EC2

#### Prerequisites:
- AWS account
- Basic Linux knowledge

#### Steps:
1. **Launch EC2 Instance**:
   - Choose Ubuntu 20.04 LTS
   - t2.micro (free tier eligible)
   - Configure security groups (port 80, 443, 22)

2. **Setup Server**:
```bash
# Connect via SSH
ssh -i your-key.pem ubuntu@your-ec2-ip

# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PM2
sudo npm install -g pm2

# Clone your repository
git clone [your-repo-url]
cd PayrollSystem

# Install dependencies
npm install
npm run build

# Start with PM2
pm2 start npm --name "payroll" -- start
pm2 startup
pm2 save
```

3. **Configure Nginx** (Optional):
```bash
sudo apt install nginx

# Create Nginx config
sudo nano /etc/nginx/sites-available/payroll

# Add configuration:
server {
    listen 80;
    server_name your-domain.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

# Enable site
sudo ln -s /etc/nginx/sites-available/payroll /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

---

## Windows Server Deployment

### For Enterprise Environments

#### Step 1: Install Prerequisites
1. **Install Node.js**:
   - Download from [nodejs.org](https://nodejs.org)
   - Choose LTS version
   - Install with default settings

2. **Install PM2**:
```cmd
npm install -g pm2
npm install -g pm2-windows-service
```

#### Step 2: Deploy Application
```cmd
# Copy application files to server
# Example: C:\PayrollSystem\

# Install dependencies
cd C:\PayrollSystem
npm install
npm run build
```

#### Step 3: Create Windows Service
```cmd
# Install PM2 as Windows Service
pm2-service-install

# Start application
pm2 start npm --name "payroll-system" -- start
pm2 save
```

#### Step 4: Configure IIS (Optional)
1. Install IIS with Application Request Routing
2. Create reverse proxy to Node.js application
3. Configure SSL certificates

---

## Linux Server Deployment

### Ubuntu/Debian Server

#### Step 1: System Setup
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PM2
sudo npm install -g pm2

# Create application user
sudo useradd -m -s /bin/bash payroll
sudo usermod -aG sudo payroll
```

#### Step 2: Deploy Application
```bash
# Switch to application user
sudo su - payroll

# Clone or copy application
git clone [repository-url] PayrollSystem
cd PayrollSystem

# Install dependencies
npm install
npm run build
```

#### Step 3: Configure PM2
```bash
# Create ecosystem file
cat > ecosystem.config.js << EOF
module.exports = {
  apps: [{
    name: 'payroll-system',
    script: 'npm',
    args: 'start',
    cwd: '/home/payroll/PayrollSystem',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G'
  }]
}
EOF

# Start application
pm2 start ecosystem.config.js
pm2 startup
pm2 save
```

#### Step 4: Configure Nginx
```bash
# Install Nginx
sudo apt install nginx

# Create site configuration
sudo nano /etc/nginx/sites-available/payroll

# Add configuration (see AWS section above)

# Enable site
sudo ln -s /etc/nginx/sites-available/payroll /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

---

## Docker Deployment

### Create Dockerfile
```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Build application
RUN npm run build

# Expose port
EXPOSE 3000

# Start application
CMD ["npm", "start"]
```

### Create docker-compose.yml
```yaml
version: '3.8'

services:
  payroll:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    restart: unless-stopped
    volumes:
      - ./data:/app/data
    
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - payroll
    restart: unless-stopped
```

### Deploy with Docker
```bash
# Build and start
docker-compose up -d

# View logs
docker-compose logs -f

# Update application
docker-compose pull
docker-compose up -d
```

---

## Network Configuration

### Port Configuration
- **Development**: Port 3000
- **Production**: Port 80 (HTTP) / 443 (HTTPS)
- **Custom**: Set via `PORT` environment variable

### Firewall Rules

#### Windows Firewall:
```cmd
# Allow inbound on port 3000
netsh advfirewall firewall add rule name="Payroll System" dir=in action=allow protocol=TCP localport=3000
```

#### Linux UFW:
```bash
# Allow port 3000
sudo ufw allow 3000

# Allow HTTP/HTTPS
sudo ufw allow 80
sudo ufw allow 443
```

### Router Configuration
1. Access router admin panel (usually 192.168.1.1)
2. Navigate to Port Forwarding
3. Forward external port 80 to internal IP:3000
4. Save configuration

---

## Security Considerations

### Basic Security
1. **Change Default Ports**:
```bash
PORT=8080 npm start
```

2. **Use HTTPS**:
   - Obtain SSL certificate (Let's Encrypt recommended)
   - Configure reverse proxy with SSL

3. **Environment Variables**:
```bash
# Create .env.production
NODE_ENV=production
PORT=3000
SESSION_SECRET=your-secret-key
```

### Advanced Security
1. **Firewall Configuration**:
   - Only allow necessary ports
   - Restrict access to specific IP ranges

2. **Regular Updates**:
```bash
# Update dependencies
npm audit
npm update
```

3. **Backup Strategy**:
   - Regular data backups
   - Database backups (if using external DB)
   - Configuration backups

### Access Control
1. **VPN Access** (Recommended for remote access)
2. **IP Whitelisting**
3. **User Authentication** (implement as needed)

---

## Monitoring and Maintenance

### PM2 Monitoring
```bash
# View status
pm2 status

# View logs
pm2 logs

# Restart application
pm2 restart payroll-system

# Monitor resources
pm2 monit
```

### System Monitoring
```bash
# Check disk space
df -h

# Check memory usage
free -h

# Check CPU usage
top
```

### Backup Scripts
```bash
#!/bin/bash
# backup.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/payroll"

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup application
tar -czf $BACKUP_DIR/payroll_$DATE.tar.gz /home/payroll/PayrollSystem

# Keep only last 7 days
find $BACKUP_DIR -name "payroll_*.tar.gz" -mtime +7 -delete

echo "Backup completed: payroll_$DATE.tar.gz"
```

---

## Troubleshooting

### Common Issues

#### 1. Port Already in Use
```bash
# Find process using port
lsof -i :3000
# Kill process
kill -9 [PID]
```

#### 2. Permission Denied
```bash
# Fix file permissions
chmod +x setup.sh
chown -R payroll:payroll /home/payroll/PayrollSystem
```

#### 3. Memory Issues
```bash
# Increase Node.js memory limit
NODE_OPTIONS="--max-old-space-size=4096" npm start
```

#### 4. Network Access Issues
- Check firewall settings
- Verify IP address configuration
- Test with `telnet [ip] [port]`

---

## Performance Optimization

### For Large Organizations (500+ employees)

1. **Database Optimization**:
   - Use external database (PostgreSQL/MySQL)
   - Implement connection pooling
   - Add database indexes

2. **Caching**:
   - Implement Redis for session storage
   - Use CDN for static assets
   - Enable browser caching

3. **Load Balancing**:
   - Multiple application instances
   - Nginx load balancer
   - Health checks

4. **Resource Monitoring**:
   - CPU and memory monitoring
   - Application performance monitoring
   - Log aggregation

---

## Deployment Checklist

### Pre-Deployment
- [ ] System requirements verified
- [ ] Dependencies installed
- [ ] Application built successfully
- [ ] Configuration files updated
- [ ] Security settings configured

### Deployment
- [ ] Application deployed to target environment
- [ ] Services started and running
- [ ] Network access configured
- [ ] SSL certificates installed (if applicable)
- [ ] Firewall rules configured

### Post-Deployment
- [ ] Application accessible from target devices
- [ ] All features tested
- [ ] Performance monitoring enabled
- [ ] Backup procedures implemented
- [ ] Documentation updated

---

**PHP Payroll v13 Deployment Guide**
*Complete deployment solutions for any environment*

For additional support or specific deployment scenarios, please refer to the main [Installation Manual](./INSTALLATION_MANUAL.md).
