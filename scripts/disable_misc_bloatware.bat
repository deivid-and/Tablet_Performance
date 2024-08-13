@echo off
adb shell pm disable-user --user 0 com.microsoft.skydrive
adb shell pm disable-user --user 0 com.google.android.apps.messaging
echo Disabled other unnecessary apps.
