@echo off
echo Turning on animations...
.\adb\adb.exe shell settings put global window_animation_scale 1
.\adb\adb.exe shell settings put global transition_animation_scale 1
.\adb\adb.exe shell settings put global animator_duration_scale 1
echo Animations turned on.
