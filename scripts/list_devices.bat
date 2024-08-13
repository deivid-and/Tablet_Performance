@echo off
adb devices | find "device" >nul 2>&1
if %errorlevel% == 0 (
    echo Device connected.
) else (
    echo No devices connected.
)
