@echo off
echo Enabling Wi-Fi...
adb shell svc wifi enable
if %errorlevel% neq 0 (echo Error: Enabling Wi-Fi failed.) else (echo Success: Enabling Wi-Fi.)
pause
