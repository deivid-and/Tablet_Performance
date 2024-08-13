@echo off
echo Boosting Wi-Fi and network performance...
.\adb\adb.exe shell svc wifi disable
.\adb\adb.exe shell svc wifi enable
.\adb\adb.exe shell settings put global mobile_data_always_on 1
echo Wi-Fi and network performance boosted.
