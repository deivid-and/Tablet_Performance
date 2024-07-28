@echo off
echo Enabling High-Performance Mode...
adb shell settings put system screen_brightness_mode 0
adb shell settings put system screen_brightness 255
adb shell settings put system stay_on_while_plugged_in 3
