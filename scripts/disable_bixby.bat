@echo off
echo Disabling Bixby agent...
.\adb\adb.exe shell pm disable-user --user 0 com.samsung.android.bixby.agent

