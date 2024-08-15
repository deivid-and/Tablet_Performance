@echo off
echo Restoring Essential Default Settings...

:: Re-enabling only the most critical services
adb shell pm enable --user 0 com.google.android.gms
adb shell pm enable --user 0 com.android.vending
adb shell pm enable --user 0 com.google.android.googlequicksearchbox

:: Reverting only the most critical system settings
adb shell settings put global limit_background_processes -1
adb shell settings put global window_animation_scale 1
adb shell settings put global transition_animation_scale 1
adb shell settings put global animator_duration_scale 1

echo Essential default settings restored.
pause
