@echo off
echo Disabling Wi-Fi...
adb shell svc wifi disable
if %errorlevel% neq 0 (echo Error: Disabling Wi-Fi failed.) else (echo Success: Disabling Wi-Fi.)
pause
