@echo off
echo Checking for software updates...
adb shell am start -n com.android.settings/.Settings\
if %errorlevel% neq 0 (echo Error: Checking for software updates failed.) else (echo Success: Checking for software updates.)
pause
