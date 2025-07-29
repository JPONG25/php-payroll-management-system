@echo off
echo ========================================
echo PHP Payroll v13 - Backup Creator
echo ========================================
echo.

set BACKUP_NAME=PayrollSystem_Backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set BACKUP_NAME=%BACKUP_NAME: =0%

echo Creating backup folder: %BACKUP_NAME%
mkdir "%BACKUP_NAME%"

echo.
echo Copying files...

echo - Documentation files
copy "README.md" "%BACKUP_NAME%\" 2>nul
copy "INSTALLATION_MANUAL.md" "%BACKUP_NAME%\" 2>nul
copy "DEPLOYMENT_GUIDE.md" "%BACKUP_NAME%\" 2>nul
copy "download-package.md" "%BACKUP_NAME%\" 2>nul

echo - Setup scripts
copy "setup.bat" "%BACKUP_NAME%\" 2>nul
copy "setup.sh" "%BACKUP_NAME%\" 2>nul

echo - Configuration files
copy "package.json" "%BACKUP_NAME%\" 2>nul
copy "package-lock.json" "%BACKUP_NAME%\" 2>nul
copy "package-scripts.json" "%BACKUP_NAME%\" 2>nul
copy "next.config.ts" "%BACKUP_NAME%\" 2>nul
copy "tsconfig.json" "%BACKUP_NAME%\" 2>nul
copy "tailwind.config.ts" "%BACKUP_NAME%\" 2>nul
copy "postcss.config.mjs" "%BACKUP_NAME%\" 2>nul
copy "eslint.config.mjs" "%BACKUP_NAME%\" 2>nul
copy "components.json" "%BACKUP_NAME%\" 2>nul
copy "next-env.d.ts" "%BACKUP_NAME%\" 2>nul

echo - Source code
xcopy "src" "%BACKUP_NAME%\src\" /E /I /Q 2>nul

echo - Public files
xcopy "public" "%BACKUP_NAME%\public\" /E /I /Q 2>nul

echo.
echo ========================================
echo Backup created successfully!
echo ========================================
echo.
echo Backup location: %BACKUP_NAME%
echo.
echo To install on another computer:
echo 1. Copy the entire %BACKUP_NAME% folder
echo 2. Run setup.bat (Windows) or setup.sh (Mac/Linux)
echo 3. Follow the instructions in README.md
echo.
echo Files included:
echo - Complete source code
echo - Installation guides
echo - Setup scripts
echo - Configuration files
echo.
pause
