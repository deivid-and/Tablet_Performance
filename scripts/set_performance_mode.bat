@echo off
echo Setting performance mode...
.\adb\adb.exe shell settings put global low_power 0
.\adb\adb.exe shell settings put global power_save_mode_trigger 0
