@echo off
echo Enabling Samsung bloatware...
adb shell pm enable com.samsung.android.bixby.agent
adb shell pm enable com.samsung.android.smartcallprovider
echo Samsung bloatware has been enabled.
