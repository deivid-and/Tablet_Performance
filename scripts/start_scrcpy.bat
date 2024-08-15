@echo off
cd /d "%~dp0\..\scrcpy" 
start scrcpy.exe --always-on-top
echo Scrcpy has been started.
