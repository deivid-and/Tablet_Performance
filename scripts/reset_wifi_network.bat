@echo off
echo Resetting Wi-Fi and network settings...
.\adb\adb.exe shell svc wifi disable
.\adb\adb.exe shell svc wifi enable
.\adb\adb.exe shell settings put global mobile_data_always_on 0
echo Wi-Fi and network settings reset to default.
