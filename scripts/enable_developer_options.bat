@echo off
echo Enabling Developer Options...
adb shell settings put global development_settings_enabled 1
adb shell settings put global adb_enabled 1