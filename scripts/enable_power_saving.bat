@echo off
echo Enabling power saving features...
.\adb\adb.exe shell settings put global low_power 1
.\adb\adb.exe shell settings put global power_save_mode_trigger 1
echo Power saving features enabled.
