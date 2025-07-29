#!/bin/bash

echo "========================================"
echo "PHP Payroll v13 - Backup Creator"
echo "========================================"
echo

# Create backup folder with timestamp
BACKUP_NAME="PayrollSystem_Backup_$(date +%Y%m%d_%H%M%S)"

echo "Creating backup folder: $BACKUP_NAME"
mkdir -p "$BACKUP_NAME"

echo
echo "Copying files..."

echo "- Documentation files"
cp README.md "$BACKUP_NAME/" 2>/dev/null
cp INSTALLATION_MANUAL.md "$BACKUP_NAME/" 2>/dev/null
cp DEPLOYMENT_GUIDE.md "$BACKUP_NAME/" 2>/dev/null
cp download-package.md "$BACKUP_NAME/" 2>/dev/null

echo "- Setup scripts"
cp setup.bat "$BACKUP_NAME/" 2>/dev/null
cp setup.sh "$BACKUP_NAME/" 2>/dev/null
cp create-backup.bat "$BACKUP_NAME/" 2>/dev/null
cp create-backup.sh "$BACKUP_NAME/" 2>/dev/null

echo "- Configuration files"
cp package.json "$BACKUP_NAME/" 2>/dev/null
cp package-lock.json "$BACKUP_NAME/" 2>/dev/null
cp package-scripts.json "$BACKUP_NAME/" 2>/dev/null
cp next.config.ts "$BACKUP_NAME/" 2>/dev/null
cp tsconfig.json "$BACKUP_NAME/" 2>/dev/null
cp tailwind.config.ts "$BACKUP_NAME/" 2>/dev/null
cp postcss.config.mjs "$BACKUP_NAME/" 2>/dev/null
cp eslint.config.mjs "$BACKUP_NAME/" 2>/dev/null
cp components.json "$BACKUP_NAME/" 2>/dev/null
cp next-env.d.ts "$BACKUP_NAME/" 2>/dev/null
cp gitignore.txt "$BACKUP_NAME/" 2>/dev/null

echo "- Source code"
cp -r src "$BACKUP_NAME/" 2>/dev/null

echo "- Public files"
cp -r public "$BACKUP_NAME/" 2>/dev/null

# Make scripts executable
chmod +x "$BACKUP_NAME/setup.sh" 2>/dev/null
chmod +x "$BACKUP_NAME/create-backup.sh" 2>/dev/null

echo
echo "========================================"
echo "Backup created successfully!"
echo "========================================"
echo
echo "Backup location: $BACKUP_NAME"
echo
echo "To install on another computer:"
echo "1. Copy the entire $BACKUP_NAME folder"
echo "2. Run setup.bat (Windows) or setup.sh (Mac/Linux)"
echo "3. Follow the instructions in README.md"
echo
echo "Files included:"
echo "- Complete source code"
echo "- Installation guides"
echo "- Setup scripts"
echo "- Configuration files"
echo
echo "Press Enter to continue..."
read
