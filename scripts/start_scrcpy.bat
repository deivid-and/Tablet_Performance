@echo off
cd /d "%~dp0\..\scrcpy-win64-v2.6.1"
start scrcpy.exe --always-on-top
echo Scrcpy has been started.
exit
