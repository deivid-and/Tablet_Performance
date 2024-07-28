@echo off
echo Optimizing battery usage...
.\adb\adb.exe shell dumpsys deviceidle force-idle
if %errorlevel% neq 0 (
    echo Error: Forcing device into deep idle mode failed.
) else (
    echo Success: Forcing device into deep idle mode.
)
