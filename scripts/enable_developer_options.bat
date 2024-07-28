@echo off
echo Enabling Developer Options...
adb shell settings put global development_settings_enabled 1
adb shell settings put global adb_enabled 1
if %errorlevel% neq 0 (echo Error: Enabling Developer Options failed.) else (echo Success: Enabling Developer Options.)
pause
