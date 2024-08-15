@echo off
echo Enabling virtual keyboard...
adb shell ime enable com.android.inputmethod.latin/.LatinIME
adb shell ime set com.android.inputmethod.latin/.LatinIME
echo Keyboard has been enabled.
