@echo off
echo Turning off animations...
.\adb\adb.exe shell settings put global window_animation_scale 0
if %errorlevel% neq 0 (
    echo Error: Turning off window animations failed.
) else (
    echo Success: Turning off window animations.
)
.\adb\adb.exe shell settings put global transition_animation_scale 0
if %errorlevel% neq 0 (
    echo Error: Turning off transition animations failed.
) else (
    echo Success: Turning off transition animations.
)
.\adb\adb.exe shell settings put global animator_duration_scale 0
if %errorlevel% neq 0 (
    echo Error: Turning off animator duration scale failed.
) else (
    echo Success: Turning off animator duration scale.
)
