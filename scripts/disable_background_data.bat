@echo off
echo Disabling battery optimization for all apps...

:: Get the list of all installed packages and save it to package_list.txt
.\adb\adb.exe shell cmd package list packages -f > package_list.txt

:: Disable battery optimization for each package
for /f "tokens=2 delims=:" %%i in ('findstr "package:" package_list.txt') do (
    .\adb\adb.exe shell dumpsys deviceidle whitelist +%%i
)

echo Battery optimization disabled for all apps.

:: Delete the package_list.txt file after execution
del package_list.txt

echo Temporary package list file deleted.
pause
