@echo off
adb shell pm disable-user --user 0 com.google.android.youtube
adb shell pm disable-user --user 0 com.google.android.gms.location.history
adb shell pm disable-user --user 0 com.google.android.googlequicksearchbox
echo Google bloatware has been disabled.
