@echo off
echo Restoring Default Settings...
adb shell pm enable --user 0 com.samsung.android.bixby.agent
adb shell pm enable --user 0 com.samsung.android.app.notes
adb shell settings put global limit_background_processes -1
adb shell settings put global window_animation_scale 1
adb shell settings put global transition_animation_scale 1
adb shell settings put global animator_duration_scale 1
adb shell settings put secure show_ime_with_hard_keyboard 1
adb shell settings put secure disable_virtual_keyboard_if_hard_keyboard 0
adb shell pm enable --user 0 com.samsung.android.calendar
adb shell pm enable --user 0 com.sec.android.app.samsungapps
adb shell pm enable --user 0 com.samsung.android.app.appsedge
adb shell pm enable --user 0 com.samsung.android.mdx
adb shell pm enable --user 0 com.samsung.android.bbc.bbcagent
adb shell pm enable --user 0 com.sec.android.widgetapp.webmanual
adb shell pm enable --user 0 com.samsung.android.app.routines
adb shell pm enable --user 0 com.google.android.googlequicksearchbox
adb shell pm enable --user 0 com.sec.android.easyMover
adb shell pm enable --user 0 com.android.chrome
adb shell pm enable --user 0 com.microsoft.skydrive
adb shell pm enable --user 0 com.netflix.mediaclient
adb shell pm enable --user 0 com.google.android.youtube
adb shell pm enable --user 0 com.samsung.android.knox.containercore
adb shell pm enable --user 0 com.samsung.android.mdx.kit
adb shell pm enable --user 0 com.android.vending
adb shell pm enable --user 0 com.google.android.gms
echo Default settings restored.
pause
