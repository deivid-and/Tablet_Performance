@echo off
echo Entering recovery mode...

:: Reboot to recovery mode
.\adb\adb.exe reboot recovery
timeout /t 10 /nobreak >nul

:: Wait for the device to enter recovery mode
echo Waiting for the device to enter recovery mode...
timeout /t 20 /nobreak >nul
