@echo off
echo Enabling battery optimization for all apps...
.\adb\adb.exe shell cmd package list packages -f > package_list.txt
for /f "tokens=2 delims=:" %%i in ('findstr "package:" package_list.txt') do (
    .\adb\adb.exe shell dumpsys deviceidle whitelist -%%i
)
echo Battery optimization enabled for all apps.
