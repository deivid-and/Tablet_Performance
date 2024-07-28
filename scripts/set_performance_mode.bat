@echo off
echo Setting performance mode...
.\adb\adb.exe shell settings put global low_power 0
if %errorlevel% neq 0 (
    echo Error: Disabling low power mode failed.
) else (
    echo Success: Disabling low power mode.
)
.\adb\adb.exe shell settings put global power_save_mode_trigger 0
if %errorlevel% neq 0 (
    echo Error: Disabling power save mode trigger failed.
) else (
    echo Success: Disabling power save mode trigger.
)
