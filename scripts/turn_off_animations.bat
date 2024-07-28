@echo off
echo Turning off animations...
.\adb\adb.exe shell settings put global window_animation_scale 0

.\adb\adb.exe shell settings put global transition_animation_scale 0

.\adb\adb.exe shell settings put global animator_duration_scale 0
