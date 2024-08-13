@echo off
echo Disabling unnecessary Samsung bloatware...

:: Disabling non-essential Samsung bloatware
adb shell pm disable-user --user 0 com.samsung.android.bixby.agent
adb shell pm disable-user --user 0 com.samsung.android.smartcallprovider

:: Note: Do not disable critical packages like the launcher
:: adb shell pm disable-user --user 0 com.sec.android.app.launcher

echo Samsung bloatware has been disabled.
