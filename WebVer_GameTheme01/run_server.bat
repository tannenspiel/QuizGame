@echo off
setlocal enabledelayedexpansion

echo Starting local web server...
echo.

REM === Автоматическое определение правильного IP ===
echo Finding your local IP address...
for /f "tokens=1,2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do (
  set IP_LINE=%%b
  set IP_ADDR=!IP_LINE:~1!
  REM Проверяем что это нормальный локальный IP (192.168.x.x или 10.x.x.x)
  echo !IP_ADDR! | findstr "192.168." >> nul
  if !errorlevel! equ 0 goto :ip_found
  echo !IP_ADDR! | findstr "10." >> nul
  if !errorlevel! equ 0 goto :ip_found
)

echo.
echo === WARNING: Could not find standard local IP ===
echo Found these IP addresses:
ipconfig | findstr "IPv4"
echo.
set /p IP_ADDR=Please enter your LOCAL IP manually (192.168.x.x): 
goto :ip_found_manual

:ip_found
echo Found local IP: !IP_ADDR!

:ip_found_manual
echo.
echo === LOCAL ACCESS ===
echo On THIS computer: http://localhost:8000/GameTheme01.html
echo.

echo === PHONE ACCESS ===
echo On your PHONE: http://!IP_ADDR!:8000/GameTheme01.html
echo.

echo === TROUBLESHOOTING ===
echo If phone link doesn't work:
echo 1. Check both devices are on same WiFi
echo 2. Check Windows Firewall allows port 8000
echo 3. Make sure IP is 192.168.x.x (not 172.x.x.x)
echo.

echo Press Ctrl+C to stop server
echo.

python -m http.server 8000

pause
