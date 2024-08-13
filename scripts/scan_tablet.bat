@echo off
setlocal

REM Define a file to save the output on the desktop
set "outputfile=%USERPROFILE%\Desktop\tablet_scan_output.txt"

REM Execute adb commands and save the output to the file
> "%outputfile%" echo Scanning tablet for installed apps and running services...
>> "%outputfile%" echo.

>> "%outputfile%" echo === Installed Apps ===
adb shell pm list packages -f >> "%outputfile%"
>> "%outputfile%" echo.

>> "%outputfile%" echo === Running Services ===
adb shell dumpsys activity services >> "%outputfile%"
>> "%outputfile%" echo.

>> "%outputfile%" echo === Battery Info ===
adb shell dumpsys battery >> "%outputfile%"
>> "%outputfile%" echo.

>> "%outputfile%" echo === Memory Info ===
adb shell dumpsys meminfo >> "%outputfile%"
>> "%outputfile%" echo.

>> "%outputfile%" echo === Network Info ===
adb shell dumpsys connectivity >> "%outputfile%"
>> "%outputfile%" echo.

>> "%outputfile%" echo === Device Info ===
adb shell getprop ro.product.model >> "%outputfile%"
adb shell getprop ro.build.version.release >> "%outputfile%"
adb shell getprop ro.build.version.sdk >> "%outputfile%"
adb shell getprop ro.build.date >> "%outputfile%"
adb shell getprop ro.build.fingerprint >> "%outputfile%"
>> "%outputfile%" echo.

>> "%outputfile%" echo Scan completed.

REM Display the output file location
echo Output saved to "%outputfile%"

endlocal
